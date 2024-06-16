import uvicorn
import mysql.connector
import firebase_admin
from firebase_admin import credentials, auth
from fastapi import FastAPI, HTTPException, Depends, Query, Header
from pyzbar.pyzbar import decode
from PIL import Image
import io
from fastapi.responses import JSONResponse
from pydantic import BaseModel, Field
import smtplib
from email.message import EmailMessage
import pyrebase
import jwt
from datetime import datetime, timedelta
import time
import threading
from fastapi import BackgroundTasks, File, UploadFile, HTTPException
import barcode
from barcode.writer import ImageWriter
import os
from typing import Optional, List, Dict
from fpdf import FPDF

app = FastAPI(
    description="Hi Emir!",
    title="DeepSeaDivers Geng",
    docs_url="/"
)

# Firebase config
firebase_config = {
    'apiKey': "AIzaSyCzeR60yMJYNO-rstkr1OsMqfvOlwwTty8",
    'authDomain': "deepseadivers-cd7cc.firebaseapp.com",
    'projectId': "deepseadivers-cd7cc",
    'storageBucket': "deepseadivers-cd7cc.appspot.com",
    'messagingSenderId': "241410608577",
    'appId': "1:241410608577:web:62d2cc9d0df907d9b23340",
    'measurementId': "G-HL68KCG3K0",
    'databaseURL': ""
}
firebase = pyrebase.initialize_app(firebase_config)

# Logic to Initialize Firebase Admin SDK
try:
    cred = credentials.Certificate("deepseadivers-firebasekey.json")
    firebase_admin.initialize_app(cred)
except ValueError:
    pass  # the default Firebase app already exists, so we do nothing for now.

# SMTP server details
smtp_server = 'smtp.gmail.com'
smtp_port = 587
sender_email = 'harmansingh.hs697@gmail.com'
sender_password = 'wygu ytgx nhjd crda'

# Function to send email notification
def send_email_notification(receiver_email: str, subject: str, content: str):
    email_content = f"""\
<html>
<head>
    <style>
        body {{
            font-family: Arial, sans-serif;
            text-align: center;
            padding: 50px;
        }}
        .message-container {{
            background-color: #f0f0f0;
            border-radius: 10px;
            padding: 30px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            display: inline-block;
        }}
    </style>
</head>
<body>
    <div class="message-container">
        <h2>{subject}</h2>
        <p>{content}</p>
    </div>
</body>
</html>
"""
    msg = EmailMessage()
    msg['Subject'] = subject
    msg['From'] = sender_email
    msg['To'] = receiver_email
    msg.add_alternative(email_content, subtype='html')

    try:
        with smtplib.SMTP(smtp_server, smtp_port) as server:
            server.starttls()
            server.login(sender_email, sender_password)
            server.send_message(msg)
            print("Email sent successfully!")
    except Exception as e:
        print(f"Failed to send email: {str(e)}")

# MySQL database connection, uses XAMPP with bone stock settings.
mysql_connection = mysql.connector.connect(
    host="127.0.0.1",
    user="root",
    password="",
    database="user_request"
)



def get_mysql_connection():
    return mysql_connection


# Utility function to get the current user
def get_current_user(token: str):
    try:
        # Decode the token to extract the payload
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        email = payload.get("email")
        user_id = payload.get("user_id")
        user_role = payload.get("user_role")
        branch = payload.get("branch")

        # Retrieve user details from Firebase using the email
        user = auth.get_user_by_email(email)

        # If user is retrieved and authenticated, return the user object and user ID
        return {"user": user, "user_id": user_id, "user_role": user_role, "branch":branch}

    except jwt.ExpiredSignatureError:
        raise HTTPException(status_code=401, detail="Token has expired")
    except jwt.DecodeError:
        raise HTTPException(status_code=401, detail="Could not decode token")
    except jwt.InvalidTokenError:
        raise HTTPException(status_code=401, detail="Invalid token")
    except auth.UserNotFoundError:
        raise HTTPException(status_code=404, detail="User not found")





#################################################### SCHEMAS ###########################################################

# Endpoint to Rescale Package Weight
class RescaleWeightSchema(BaseModel):
    shipment_id: int
    scale_factor: float

@app.put('/centra/rescale_package_weight')
async def rescale_package_weight(rescale_data: RescaleWeightSchema, current_user: dict = Depends(get_current_user)):
    shipment_id = rescale_data.shipment_id
    scale_factor = rescale_data.scale_factor

    cursor = mysql_connection.cursor()
    # Fetch the current weight of the shipment
    select_query = "SELECT package_weight FROM centra_shipments WHERE id = %s AND user_id = %s"
    cursor.execute(select_query, (shipment_id, current_user['user_id']))
    shipment = cursor.fetchone()

    if not shipment:
        cursor.close()
        raise HTTPException(status_code=404, detail="Shipment not found")

    current_weight = shipment[0]
    new_weight = current_weight * scale_factor

    # Update the package weight
    update_query = "UPDATE centra_shipments SET package_weight = %s WHERE id = %s AND user_id = %s"
    cursor.execute(update_query, (new_weight, shipment_id, current_user['user_id']))
    mysql_connection.commit()
    cursor.close()

    return {"message": "Package weight rescaled successfully", "new_weight": new_weight}

# SignUpSchema 
class SignUpSchema(BaseModel):
    username: str
    email: str
    password: str
    user_role: str = Field(..., pattern="^(Centra|XYZ|Harbor)$")
    country_code: str
    phone_number: str
    first_name: str
    last_name: str
    branch: str  # Add the branch field

# AdminApprovalSchema
class AdminApprovalSchema(BaseModel):
    email: str
    decision: str = Field(..., pattern="^(yes|no)$")



# AdminEditSchema
class UserEditSchema(BaseModel):
    username: Optional[str]
    email: Optional[str]
    user_role: Optional[str] = Field(None, pattern="^(Centra|XYZ|Harbor)$")
    phone_number: Optional[str]
    first_name: Optional[str]
    last_name: Optional[str]
    branch: Optional[str]


# LoginSchema
class LoginSchema(BaseModel):
    email: str
    password: str

# ResetPasswordSchema
class ResetPasswordSchema(BaseModel):
    old_password: str
    new_password: str

# MoringaLeavesSchema
class MoringaLeavesSchema(BaseModel):
    date_received: str
    weight_received: float
    expiry_time: str



# DryingResultsSchema
class DryingResultsSchema(BaseModel):
    date_dried: str
    weight_dried: float
    
# DryingResultFind
class DryingResultFind(BaseModel):
    centra_name: str
    production_date: str  
    

# ShipmentSchema
class ShipmentSchema(BaseModel):
    date_shipped: str
    expedition: str
    total_package: int
    package_weight: float


# MoringaBatchesSchema
class MoringaBatchesSchema(BaseModel):
    weight_received: float
    entryDate: str



#BarcodeScannerSchema
class Barcode(BaseModel):
    barcode_data: str
    barcode_type: str    


#WeightUpdateSchema
class WeightUpdateSchema(BaseModel):
    centra_name: str
    new_weight: float


class DeleteLatestBatchRequest(BaseModel):
    centra_name: str


############################################################### SCHEMA END ##################################################
############################################################### FUNCTIONS ###################################################
def create_token(email: str) -> str:
    # token expiration (10 hours from the current time)
    expiration = datetime.utcnow() + timedelta(hours=10)

    # Fetch user details from SQL database based on email
    cursor = mysql_connection.cursor()
    select_query = "SELECT username, id, user_role, branch, first_name, last_name FROM user_signups WHERE email = %s"
    cursor.execute(select_query, (email,))
    result = cursor.fetchone()
    cursor.close()

    if not result:
        raise HTTPException(status_code=404, detail="User not found")

    # Extract user details from the SQL query result
    username, user_id, user_role, branch, first_name, last_name = result

    # Create token payload including username, email, user ID, user_role, branch, and expiration time
    token_payload = {
        "username": username,
        "email": email,
        "user_id": user_id,
        "user_role": user_role,
        "branch": branch,
        "first_name": first_name,
        "last_name": last_name,
        "exp": expiration
    }

    # Generate token using JWT library
    token = jwt.encode(token_payload, SECRET_KEY, algorithm=ALGORITHM)
    return token







def generate_barcode(barcode_value: str, save_path: str):
    code128 = barcode.get_barcode_class('code128')
    barcode_obj = code128(barcode_value, writer=ImageWriter())
    barcode_obj.save(save_path)
############################################################ FUNCTIONS END ########################################################
########################################################### VARIABLES #############################################################
SECRET_KEY = "epik_key"
ALGORITHM = "HS256"
barcode_directory = "barcodedirectory"
os.makedirs(barcode_directory, exist_ok=True)
######################################################### VARIABLES END ##############################################################
############################################################ ENDPOINTS ##############################################################

@app.post('/signup')
async def create_an_account(user_data: SignUpSchema):
    username = user_data.username
    email = user_data.email
    password = user_data.password
    user_role = user_data.user_role
    country_code = user_data.country_code
    phone_number = user_data.phone_number
    first_name = user_data.first_name
    last_name = user_data.last_name
    branch = user_data.branch  # Get branch from the request

    # Store user information in MySQL database with 'pending' status
    cursor = mysql_connection.cursor()
    insert_query = """
        INSERT INTO user_signups (username, email, password, user_role, country_code, phone_number, first_name, last_name, branch, status)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
    """
    cursor.execute(insert_query, (username, email, password, user_role, country_code, phone_number, first_name, last_name, branch, 'pending'))
    mysql_connection.commit()
    cursor.close()

    # Notify admin's email about the sign-up request
    admin_email = "mat.dk1001au@gmail.com"

    admin_message = f"New user sign-up request:\nUsername: {username}\nEmail: {email}\nPassword: {password}\nUser Role: {user_role}\nCountry Code: {country_code}\nPhone Number: {phone_number}\nFirst Name: {first_name}\nLast Name: {last_name}\nBranch: {branch}"
    email_content = f"{admin_message}\n\nPlease review and approve this request."

    send_email_notification(admin_email, "Approval Request for User Sign-Up", email_content)

    return JSONResponse(
        content={"message": "User sign-up request sent for admin approval."},
        status_code=201
    )

@app.post('/admin/approve')
async def admin_decision(approval_data: AdminApprovalSchema):
    email = approval_data.email
    decision = approval_data.decision

    if decision.lower() not in ['yes', 'no']:
        raise HTTPException(status_code=400, detail="Invalid decision. Use 'yes' or 'no'.")

    cursor = mysql_connection.cursor()
    select_query = "SELECT * FROM user_signups WHERE email = %s AND status = 'pending'"
    cursor.execute(select_query, (email,))
    user_data = cursor.fetchone()

    if user_data:
        if decision.lower() == 'yes':
            try:
                user = auth.create_user(email=email, password=user_data[2])
                update_query = "UPDATE user_signups SET status = 'approved' WHERE email = %s"
                cursor.execute(update_query, (email,))
                mysql_connection.commit()
                cursor.close()
                return JSONResponse(content={"message": f"User account created successfully for {email}"}, status_code=200)
            except Exception as e:
                return JSONResponse(content={"message": f"Failed to create user account: {str(e)}"}, status_code=500)
        elif decision.lower() == 'no':
            delete_query = "DELETE FROM user_signups WHERE email = %s"
            cursor.execute(delete_query, (email,))
            mysql_connection.commit()
            cursor.close()
            return JSONResponse(content={"message": f"User sign-up request for {email} rejected."}, status_code=200)
    else:
        raise HTTPException(status_code=404, detail="User sign-up request not found or already approved/rejected.")



@app.put('/admin/edit/{user_id}')
async def edit_user(user_id: int, user_data: UserEditSchema):
    cursor = mysql_connection.cursor()
    
    # Get current user data
    cursor.execute("SELECT email FROM user_signups WHERE id = %s", (user_id,))
    existing_user = cursor.fetchone()
    if not existing_user:
        raise HTTPException(status_code=404, detail="User not found.")
    
    current_email = existing_user[0]

    update_fields = []
    update_values = []
    
    for field, value in user_data.dict().items():
        if value is not None:
            update_fields.append(f"{field} = %s")
            update_values.append(value)
    
    if not update_fields:
        raise HTTPException(status_code=400, detail="No valid fields provided for update.")
    
    update_values.append(user_id)
    update_query = f"UPDATE user_signups SET {', '.join(update_fields)} WHERE id = %s"
    
    try:
        cursor.execute(update_query, tuple(update_values))
        mysql_connection.commit()
        
        if cursor.rowcount == 0:
            raise HTTPException(status_code=404, detail="User not found.")
        
        # Update email in Firebase if email was changed
        if user_data.email and user_data.email != current_email:
            try:
                user = auth.get_user_by_email(current_email)
                auth.update_user(
                    user.uid,
                    email=user_data.email
                )
            except Exception as e:
                raise HTTPException(status_code=500, detail=f"Failed to update Firebase user email: {str(e)}")
        
        return {"message": "User information updated successfully."}
    except Exception as e:
        mysql_connection.rollback()
        raise HTTPException(status_code=500, detail=f"Failed to update user information: {str(e)}")
    finally:
        cursor.close()



@app.post('/login')
async def login(login_data: LoginSchema):
    email = login_data.email
    password = login_data.password

    cursor = mysql_connection.cursor()
    select_query = "SELECT password, status FROM user_signups WHERE email = %s"
    cursor.execute(select_query, (email,))
    result = cursor.fetchone()
    
    if not result:
        cursor.close()
        raise HTTPException(status_code=400, detail="Invalid credentials")

    stored_password, status = result

    if stored_password != password:
        cursor.close()
        raise HTTPException(status_code=400, detail="Invalid credentials")

    if status != "approved":
        cursor.close()
        raise HTTPException(status_code=400, detail="User account not approved")

    try:
        # Generate token with username, email, and user ID
        token = create_token(email)

        # Return success response with token
        return JSONResponse(
            content={"message": "Login successful", "token": token},
            status_code=200
        )
    except Exception as e:
        cursor.close()
        raise HTTPException(
            status_code=400,
            detail=f"Login failed: {str(e)}"
        )

# Utility function to get the current user
def get_current_user(token: str):
    try:
        # Decode the token to extract the payload
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        email = payload.get("email")
        user_id = payload.get("user_id")
        user_role = payload.get("user_role")
        branch = payload.get("branch")
        first_name = payload.get("first_name")
        last_name = payload.get("last_name")

        # Retrieve user details from Firebase using the email
        user = auth.get_user_by_email(email)

        # If user is retrieved and authenticated, return the user object and user ID
        return {"user": user, "user_id": user_id, "user_role": user_role, "branch":branch, "first_name":first_name, "last_name":last_name}

    except jwt.ExpiredSignatureError:
        raise HTTPException(status_code=401, detail="Token has expired")
    except jwt.DecodeError:
        raise HTTPException(status_code=401, detail="Could not decode token")
    except jwt.InvalidTokenError:
        raise HTTPException(status_code=401, detail="Invalid token")
    except auth.UserNotFoundError:
        raise HTTPException(status_code=404, detail="User not found")






def update_remaining_time(machine_id: int, duration: int):
    cursor = mysql_connection.cursor()
    try:
        for remaining in range(duration, -1, -1):
            cursor.execute("UPDATE centra_machine_drying_status SET remaining_time = %s WHERE machine_id = %s", (remaining, machine_id))
            mysql_connection.commit()
            time.sleep(1)

        # Set current_weight to 0 and is_processing to 0 after the timer finishes
        cursor.execute("UPDATE centra_machine_drying_status SET current_weight = 0, is_processing = 0 WHERE machine_id = %s", (machine_id,))
        mysql_connection.commit()
    except mysql.connector.Error as e:
        mysql_connection.rollback()
        raise HTTPException(status_code=500, detail=f"Database error: {str(e)}")
    finally:
        cursor.close()

@app.post('/centra/start_machine/{machine_id}')
def start_machine(machine_id: int, background_tasks: BackgroundTasks):
    cursor = mysql_connection.cursor()

    try:
        # Check if the machine exists and get the current state
        cursor.execute("SELECT is_processing FROM centra_machine_drying_status WHERE machine_id = %s", (machine_id,))
        result = cursor.fetchone()
        if result is None:
            raise HTTPException(status_code=404, detail="Machine not found")

        is_processing = result[0]
        if is_processing:
            raise HTTPException(status_code=400, detail="Machine is already processing")

        # Start the machine
        cursor.execute("UPDATE centra_machine_drying_status SET is_processing = 1, remaining_time = 60 WHERE machine_id = %s", (machine_id,))
        mysql_connection.commit()

        # Add the background task to update the timer
        background_tasks.add_task(update_remaining_time, machine_id, 60)

        return {"message": "Machine started successfully"}

    except mysql.connector.Error as e:
        mysql_connection.rollback()
        raise HTTPException(status_code=500, detail=f"Database error: {str(e)}")
    finally:
        cursor.close()








@app.get('/current_user')
async def get_current_user_details(Authorization: Optional[str] = Header(None)):
    if Authorization is None:
        raise HTTPException(status_code=401, detail="Authorization header missing")

    try:
        token = Authorization.split(" ")[1]
    except IndexError:
        raise HTTPException(status_code=401, detail="Invalid Authorization header format")

    current_user = get_current_user(token)
    return current_user



@app.post('/reset_password')
async def reset_password(reset_data: ResetPasswordSchema, current_user: dict = Depends(get_current_user)):
    old_password = reset_data.old_password
    new_password = reset_data.new_password

    # Check if old password matches the stored password
    cursor = mysql_connection.cursor()
    select_query = "SELECT password FROM user_signups WHERE id = %s"
    cursor.execute(select_query, (current_user['user_id'],))
    stored_password = cursor.fetchone()[0]
    cursor.close()

    if stored_password != old_password:
        return {"message": "Old password does not match. Password not reset."}

    # Update password in MySQL database
    cursor = mysql_connection.cursor()
    update_query = "UPDATE user_signups SET password = %s WHERE id = %s"
    cursor.execute(update_query, (new_password, current_user['user_id']))
    mysql_connection.commit()
    cursor.close()

    # Update password in Firebase
    try:
        user = auth.get_user(current_user['user'].uid)
        auth.update_user(
            user.uid,
            password=new_password
        )
        return {"message": "Password reset successfully in MySQL and Firebase"}
    except Exception as e:
        return {"message": f"Failed to reset password: {str(e)}"}



@app.post('/centra/drying_machine_update_weight')
def dyring_machine_update_weight(weight_update: WeightUpdateSchema):
    cursor = mysql_connection.cursor()

    try:
        # Check if the machine with the given centra_name exists
        cursor.execute("SELECT machine_id FROM centra_machine_drying_status WHERE centra_name = %s", (weight_update.centra_name,))
        result = cursor.fetchone()
        if result is None:
            raise HTTPException(status_code=404, detail="Machine with given centra name not found")

        # Update the current weight of the machine
        cursor.execute("UPDATE centra_machine_drying_status SET current_weight = %s WHERE centra_name = %s", (weight_update.new_weight, weight_update.centra_name))
        mysql_connection.commit()

        return {"message": "Machine weight updated successfully"}

    except mysql.connector.Error as e:
        mysql_connection.rollback()
        raise HTTPException(status_code=500, detail=f"Database error: {str(e)}")
    finally:
        cursor.close()



@app.post('/centra/moringa_batches')
def record_moringa_batches(moringa_data: MoringaBatchesSchema, current_user: dict = Depends(get_current_user)):
    current_time = datetime.now()
    entryDate = datetime.strptime(moringa_data.entryDate, "%Y-%m-%d").date()
    entryTime = current_time.strftime("%H:%M:%S")
    expiry_time = current_time + timedelta(hours=4)

    cursor = mysql_connection.cursor()

    try:
        centra_name = current_user.get('branch')

        insert_query = """
            INSERT INTO centra_moringa_batches (centra_name, entryDate, entryTime, weight_received, expiry_time, processing_state)
            VALUES (%s, %s, %s, %s, %s, %s)
        """
        cursor.execute(insert_query, (centra_name, entryDate, entryTime, moringa_data.weight_received, expiry_time, False))
        mysql_connection.commit()

        return {"message": "Moringa batch recorded successfully with expiry time."}

    except mysql.connector.Error as e:
        mysql_connection.rollback()
        raise HTTPException(status_code=500, detail=f"Failed to record moringa batch: {str(e)}")

    finally:
        cursor.close()


@app.delete('/centra/moringa_batches/latest')
def delete_latest_moringa_batch(request: DeleteLatestBatchRequest, current_user: dict = Depends(get_current_user)):
    centra_name = request.centra_name
    cursor = mysql_connection.cursor()

    try:
        # Find the latest batch id for the given centra_name
        select_query = """
            SELECT id
            FROM centra_moringa_batches
            WHERE centra_name = %s
            ORDER BY id DESC
            LIMIT 1
        """
        cursor.execute(select_query, (centra_name,))
        latest_batch = cursor.fetchone()

        if latest_batch:
            latest_batch_id = latest_batch[0]

            # Delete the latest batch
            delete_query = """
                DELETE FROM centra_moringa_batches
                WHERE id = %s
            """
            cursor.execute(delete_query, (latest_batch_id,))
            mysql_connection.commit()

            return {"message": f"Latest batch for {centra_name} deleted successfully."}
        else:
            raise HTTPException(status_code=404, detail=f"No batches found for {centra_name}")

    except mysql.connector.Error as e:
        mysql_connection.rollback()
        raise HTTPException(status_code=500, detail=f"Failed to delete latest batch: {str(e)}")

    finally:
        cursor.close()


@app.post('/centra/drying_results')
def insert_drying_result(drying_data: DryingResultsSchema, current_user: dict = Depends(get_current_user)):
    cursor = mysql_connection.cursor()

    try:
        centra_name = current_user.get('branch')

        insert_query = """
            INSERT INTO centra_drying_results (centra_name, date_dried, weight_dried)
            VALUES (%s, %s, %s)
        """
        cursor.execute(insert_query, (centra_name, drying_data.date_dried, drying_data.weight_dried))
        mysql_connection.commit()

        return {"message": "Drying result recorded successfully."}

    except mysql.connector.Error as e:
        mysql_connection.rollback()
        raise HTTPException(status_code=500, detail=f"Failed to record drying result: {str(e)}")

    finally:
        cursor.close()

@app.get('/centra/dried_leaves_batch')
def get_dried_leaves_batch(centra_name: str, production_date: str):
    cursor = mysql_connection.cursor()

    try:
        # Execute SQL query to fetch dried leaves batch
        select_query = """
            SELECT id, centra_name, date_dried, weight_dried
            FROM centra_drying_results
            WHERE centra_name = %s AND date_dried = %s
        """
        cursor.execute(select_query, (centra_name, production_date))
        result = cursor.fetchone()

        if result:
            dried_leaves_batch = {
                'id': result[0],
                'centra_name': result[1],
                'date_dried': result[2].strftime('%Y-%m-%d'),
                'weight_dried': result[3]
            }
            return dried_leaves_batch
        else:
            raise HTTPException(status_code=404, detail=f"No dried leaves batch found for {centra_name} on {production_date}")

    except mysql.connector.Error as e:
        raise HTTPException(status_code=500, detail=f"Failed to fetch dried leaves batch: {str(e)}")

    finally:
        cursor.close()







@app.post('/centra/shipments')
async def record_shipment(shipment_data: ShipmentSchema, current_user: dict = Depends(get_current_user)):
    date_shipped = shipment_data.date_shipped
    expedition = shipment_data.expedition
    total_package = shipment_data.total_package
    package_weight = shipment_data.package_weight

    # Generate barcode
    barcode_value = f"{date_shipped}-{expedition}-{total_package}"
    barcode_filename = f"barcode_{date_shipped}_{expedition}_{total_package}.png"
    barcode_image_path = os.path.join(barcode_directory, barcode_filename)
    generate_barcode(barcode_value, barcode_image_path)

    cursor = mysql_connection.cursor()
    insert_query = """
        INSERT INTO centra_shipments (user_id, date_shipped, expedition, total_package, package_weight, barcode)
        VALUES (%s, %s, %s, %s, %s, %s)
    """
    cursor.execute(insert_query, (current_user['user_id'], date_shipped, expedition, total_package, package_weight, barcode_image_path))
    mysql_connection.commit()
    cursor.close()
    return {"message": "Shipment recorded successfully"}




@app.post('/generate-barcode/')
async def generate_barcode_endpoint(data: MoringaBatchesSchema):
    # Extract data from request
    weight_received = data.weight_received
    date_received = data.date_received

    # Generate a barcode identifier using the date and weight
    barcode_id = f"{date_received.replace('-', '')}{int(weight_received)}"
    # Define the path where the barcode image will be saved
    barcode_filename = f"barcode_{barcode_id}.png"
    barcode_image_path = os.path.join(barcode_directory, barcode_filename)
    
    # Generate the barcode
    generate_barcode(barcode_id, barcode_image_path)
    
    return JSONResponse(content={"message": "Barcode generated successfully.", "barcode_filename": barcode_filename}, status_code=201)




@app.post("/scan-barcode/", response_model=List[Barcode])
async def scan_barcode(file: UploadFile = File(...)):
    contents = await file.read()
    
    # Decode the barcode
    decoded_objects = decode(Image.open(io.BytesIO(contents)))
    if not decoded_objects:
        raise HTTPException(status_code=400, detail="No barcode found")


    # Extract barcode data
    barcodes = []
    for obj in decoded_objects:
        barcode_data = obj.data.decode('utf-8')
        barcode_type = obj.type
        barcodes.append(Barcode(barcode_data=barcode_data, barcode_type=barcode_type))
    
    return barcodes

# Endpoint to generate receipt
@app.get('/centra/generate_receipt/{shipment_id}')
async def generate_receipt(shipment_id: int, current_user: dict = Depends(get_current_user)):
    cursor = mysql_connection.cursor()
    select_query = """
        SELECT date_shipped, expedition, total_package, package_weight, barcode 
        FROM centra_shipments 
        WHERE id = %s AND user_id = %s
    """
    cursor.execute(select_query, (shipment_id, current_user['user_id']))
    shipment = cursor.fetchone()
    cursor.close()

    if not shipment:
        raise HTTPException(status_code=404, detail="Shipment not found")

    date_shipped, expedition, total_package, package_weight, barcode_path = shipment

    # Generate a PDF receipt
    pdf = FPDF()
    pdf.add_page()
    pdf.set_font("Arial", size=12)
    pdf.cell(200, 10, txt="Shipment Receipt", ln=True, align='C')
    pdf.cell(200, 10, txt=f"Date Shipped: {date_shipped}", ln=True, align='L')
    pdf.cell(200, 10, txt=f"Expedition: {expedition}", ln=True, align='L')
    pdf.cell(200, 10, txt=f"Total Packages: {total_package}", ln=True, align='L')
    pdf.cell(200, 10, txt=f"Package Weight: {package_weight} kg", ln=True, align='L')
    
    pdf.image(barcode_path, x=10, y=80, w=100)

    receipt_filename = f"receipt_{shipment_id}.pdf"
    receipt_path = os.path.join(barcode_directory, receipt_filename)
    pdf.output(receipt_path)

    return JSONResponse(content={"message": "Receipt generated successfully", "receipt_path": receipt_path})


######################################################### ENDPOINTS END ############################################################
######################################################## START APPLICATION #########################################################

if __name__ == "__main__":
    uvicorn.run("main:app", host="127.0.0.1", port=8000, reload=True)
