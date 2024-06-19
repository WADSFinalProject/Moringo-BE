import uvicorn
import mysql.connector
import firebase_admin
from firebase_admin import credentials, auth
from fastapi import FastAPI, HTTPException, Depends, Query, Header
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
from fastapi import BackgroundTasks, File, UploadFile, HTTPException, APIRouter
from fastapi.middleware.cors import CORSMiddleware
import barcode
from barcode.writer import ImageWriter
import os
from typing import Optional, List, Dict
from fpdf import FPDF
from google.cloud.sql.connector import connector
import pymysql
import sqlalchemy
from mysql.connector import Error

app = FastAPI(
    description="Hi Emir!",
    title="DeepSeaDivers Geng",
    docs_url="/"
)

# Add CORS middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["https://moringo-fe-eta.vercel.app/"], 
    allow_credentials=True,
    allow_methods=["GET", "POST", "PUT", "DELETE"],
    allow_headers=["*"],
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


# Cloud SQL database connection
Connector = connector

def get_mysql_connection():
    try:
       
        conn = mysql.connector.connect(
            host='dsdbetter.cpqwe6mas9r9.ap-southeast-1.rds.amazonaws.com',  
            user='admin',      
            password='moringohiemir',
            database= 'user_request'  
        )
        if conn.is_connected():
            print("Connected to MySQL database")
            return conn
    except Error as e:
        print(f"Error connecting to MySQL database: {str(e)}")
        return None


mysql_connection = get_mysql_connection()




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
    branch: Optional[str] = None  # Add the branch field

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

# MoringaBatchUpdateSchema
class MoringaBatchUpdateSchema(BaseModel):
    entryDate: Optional[str]
    weight_received: Optional[float]

# DryingResultsSchema
class DryingResultsSchema(BaseModel):
    centra_name: str
    date_dried: str
    weight_dried: float
    
# DryingResultFind
class DryingResultFind(BaseModel):
    centra_name: str
    production_date: str  
    

# ShipmentSchema
class ShipmentSchema(BaseModel):
    package_weight: float
    powder_batch_id: int
    total_package: int
    centra_sender: str
    sender_address: str
    receiver_address: str
    expedition: str
    date_shipped: str


# MoringaBatchesSchema
class MoringaBatchesSchema(BaseModel):
    weight_received: float
    entryDate: str
    centra_name: str

#UpdateProcessingSchema
class UpdateProcessingSchema(BaseModel):
    ids: List[int]

# StartMachineSchema
class StartMachineSchema(BaseModel):
    last_started: Optional[datetime]
    finished_time: Optional[datetime]

#BarcodeScannerSchema
class Barcode(BaseModel):
    barcode_data: str
    barcode_type: str    


class WeightUpdateSchema(BaseModel):
    centra_name: str
    new_weight: float
    is_processing: Optional[int] = Field(0)

class StatusUpdateSchema(BaseModel):
    centra_name: str
    is_processing: Optional[int] = Field(0)

class DeleteBatchesRequest(BaseModel):
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

    try:
        # Use context manager for cursor
        with mysql_connection.cursor() as cursor:
            # Store user information in MySQL database with 'pending' status
            insert_query = """
                INSERT INTO user_signups (username, email, password, user_role, country_code, phone_number, first_name, last_name, branch, status)
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
            """
            cursor.execute(insert_query, (username, email, password, user_role, country_code, phone_number, first_name, last_name, branch, 'pending'))
            mysql_connection.commit()

        # Notify admin's email about the sign-up request
        admin_email = "mat.dk1001au@gmail.com"

        admin_message = f"New user sign-up request:\nUsername: {username}\nEmail: {email}\nPassword: {password}\nUser Role: {user_role}\nCountry Code: {country_code}\nPhone Number: {phone_number}\nFirst Name: {first_name}\nLast Name: {last_name}\nBranch: {branch}"
        email_content = f"{admin_message}\n\nPlease review and approve this request."

        send_email_notification(admin_email, "Approval Request for User Sign-Up", email_content)

        return JSONResponse(
            content={"message": "User sign-up request sent for admin approval."},
            status_code=201
        )

    except mysql.connector.Error as e:
        print(f"Database error occurred: {e}")
        raise HTTPException(status_code=500, detail="An error occurred while processing the sign-up request.")
    except Exception as e:
        print(f"An unexpected error occurred: {e}")
        raise HTTPException(status_code=500, detail="An unexpected error occurred.")

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
                # Check if user already exists in Firebase
                existing_user = None
                try:
                    existing_user = auth.get_user_by_email(email)
                except auth.UserNotFoundError:
                    pass

                if existing_user:
                    # User already exists, update status in MySQL
                    update_query = "UPDATE user_signups SET status = 'approved' WHERE email = %s"
                    cursor.execute(update_query, (email,))
                    mysql_connection.commit()
                    cursor.close()
                    return JSONResponse(content={"message": f"User account for {email} already exists and is now approved."}, status_code=200)
                else:
                    # Create new user in Firebase
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

@app.get('/centra/drying_machine_remaining_time/{centra_name}')
def get_drying_machine_remaining_time(centra_name: str):
    cursor = mysql_connection.cursor()

    try:
        # Query to get the remaining time for the specified centra_name
        query = "SELECT remaining_time, is_processing, current_weight, last_started FROM centra_machine_drying_status WHERE centra_name = %s"
        cursor.execute(query, (centra_name,))
        result = cursor.fetchone()

        if result is None:
            raise HTTPException(status_code=404, detail="Machine with given centra_name not found")

        remaining_time = result[0]
        is_processing = result[1]
        current_weight = result[2]
        last_started = result[3]
        return {"centra_name": centra_name, "remaining_time": remaining_time, "is_processing": is_processing, "current_weight": current_weight, "last_started": last_started}

    except mysql.connector.Error as e:
        raise HTTPException(status_code=500, detail=f"Database error: {str(e)}")
    finally:
        cursor.close()

@app.get('/centra/powder_machine_remaining_time/{centra_name}')
def get_drying_machine_remaining_time(centra_name: str):
    cursor = mysql_connection.cursor()

    try:
        # Query to get the remaining time for the specified centra_name
        query = "SELECT remaining_time, is_processing, current_weight, last_started FROM centra_machine_powder_status WHERE centra_name = %s"
        cursor.execute(query, (centra_name,))
        result = cursor.fetchone()

        if result is None:
            raise HTTPException(status_code=404, detail="Machine with given centra_name not found")

        remaining_time = result[0]
        is_processing = result[1]
        current_weight = result[2]
        last_started = result[3]
        return {"centra_name": centra_name, "remaining_time": remaining_time, "is_processing": is_processing, "current_weight": current_weight, "last_started": last_started}

    except mysql.connector.Error as e:
        raise HTTPException(status_code=500, detail=f"Database error: {str(e)}")
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






def update_remaining_time(centra_name: str, duration: int):
    cursor = mysql_connection.cursor()
    try:
        for remaining in range(duration, -1, -1):
            cursor.execute("UPDATE centra_machine_drying_status SET remaining_time = %s WHERE centra_name = %s", (remaining, centra_name))
            mysql_connection.commit()
            time.sleep(1)

        mysql_connection.commit()
    except mysql.connector.Error as e:
        mysql_connection.rollback()
        raise HTTPException(status_code=500, detail=f"Database error: {str(e)}")
    finally:
        cursor.close()

def update_remaining_time_powder(centra_name: str, duration: int):
    cursor = mysql_connection.cursor()
    try:
        for remaining in range(duration, -1, -1):
            cursor.execute("UPDATE centra_machine_powder_status SET remaining_time = %s WHERE centra_name = %s", (remaining, centra_name))
            mysql_connection.commit()
            time.sleep(1)

        mysql_connection.commit()
    except mysql.connector.Error as e:
        mysql_connection.rollback()
        raise HTTPException(status_code=500, detail=f"Database error: {str(e)}")
    finally:
        cursor.close()

@app.post('/centra/start_machine/{centra_name}')
def start_machine(centra_name: str, background_tasks: BackgroundTasks, start_data: StartMachineSchema):
    cursor = mysql_connection.cursor()

    try:
        # Check if the machine exists and get the current state
        cursor.execute("SELECT is_processing FROM centra_machine_drying_status WHERE centra_name = %s", (centra_name,))
        result = cursor.fetchone()
        if result is None:
            raise HTTPException(status_code=404, detail="Machine not found")

        is_processing = result[0]
        if is_processing:
            raise HTTPException(status_code=400, detail="Machine is already processing")

        # Validate and process input for last_started and finished_time
        if not start_data.last_started or not start_data.finished_time:
            raise HTTPException(status_code=400, detail="Both last_started and finished_time must be provided")

        # Start the machine with provided last_started and finished_time
        update_fields = {
            "is_processing": 1,
            "last_started": start_data.last_started,
            "finished_time": start_data.finished_time
        }

        update_query = """
            UPDATE centra_machine_drying_status 
            SET {update_values}
            WHERE centra_name = %s
        """.format(update_values=", ".join([f"{field} = %s" for field in update_fields.keys()]))

        cursor.execute(update_query, tuple(update_fields.values()) + (centra_name,))
        mysql_connection.commit()

        # Add the background task to update the timer
        background_tasks.add_task(update_remaining_time, centra_name, 86400)

        return {"message": "Machine started successfully", "last_started": start_data.last_started, "finished_time": start_data.finished_time}

    except mysql.connector.Error as e:
        mysql_connection.rollback()
        raise HTTPException(status_code=500, detail=f"Database error: {str(e)}")
    finally:
      cursor.close()


@app.post('/centra/start_powder_machine/{centra_name}')
def start_powder_machine(centra_name: str, background_tasks: BackgroundTasks, start_data: StartMachineSchema):
    cursor = mysql_connection.cursor()

    try:
        # Check if the machine exists and get the current state
        cursor.execute("SELECT is_processing FROM centra_machine_powder_status WHERE centra_name = %s", (centra_name,))
        result = cursor.fetchone()
        if result is None:
            raise HTTPException(status_code=404, detail="Machine not found")

        is_processing = result[0]
        if is_processing:
            raise HTTPException(status_code=400, detail="Machine is already processing")
        
        # Validate and process input for last_started and finished_time
        if not start_data.last_started or not start_data.finished_time:
            raise HTTPException(status_code=400, detail="Both last_started and finished_time must be provided")

        # Start the machine with provided last_started and finished_time
        update_fields = {
            "is_processing": 1,
            "last_started": start_data.last_started,
            "finished_time": start_data.finished_time
        }

        update_query = """
            UPDATE centra_machine_powder_status 
            SET {update_values}
            WHERE centra_name = %s
        """.format(update_values=", ".join([f"{field} = %s" for field in update_fields.keys()]))

        cursor.execute(update_query, tuple(update_fields.values()) + (centra_name,))
        mysql_connection.commit()

        # Add the background task to update the timer
        background_tasks.add_task(update_remaining_time_powder, centra_name, 172800)

        return {"message": "Machine started successfully", "last_started": start_data.last_started, "finished_time": start_data.finished_time}

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
def drying_machine_update_weight(weight_update: WeightUpdateSchema):
    cursor = mysql_connection.cursor()

    try:
        # Check if the machine with the given centra_name exists
        cursor.execute("SELECT machine_id FROM centra_machine_drying_status WHERE centra_name = %s", (weight_update.centra_name,))
        result = cursor.fetchone()
        if result is None:
            raise HTTPException(status_code=404, detail="Machine with given centra name not found")

        # Update the current weight and is_processing status of the machine
        cursor.execute(
            "UPDATE centra_machine_drying_status SET current_weight = %s, is_processing = %s WHERE centra_name = %s",
            (weight_update.new_weight, weight_update.is_processing, weight_update.centra_name)
        )
        mysql_connection.commit()

        return {"message": "Machine weight and processing status updated successfully"}

    except mysql.connector.Error as e:
        mysql_connection.rollback()
        raise HTTPException(status_code=500, detail=f"Database error: {str(e)}")
    finally:
        cursor.close()

@app.post('/centra/powder_machine_update_status')
def powder_machine_update_status(status_update: StatusUpdateSchema):
    cursor = mysql_connection.cursor()

    try:
        # Check if the machine with the given centra_name exists
        cursor.execute("SELECT machine_id FROM centra_machine_powder_status WHERE centra_name = %s", (status_update.centra_name,))
        result = cursor.fetchone()
        if result is None:
            raise HTTPException(status_code=404, detail="Machine with given centra name not found")

        # Update the current weight and is_processing status of the machine
        cursor.execute(
            "UPDATE centra_machine_powder_status SET is_processing = %s WHERE centra_name = %s",
            (status_update.is_processing, status_update.centra_name)
        )
        mysql_connection.commit()

        return {"message": "Machine weight and processing status updated successfully"}

    except mysql.connector.Error as e:
        mysql_connection.rollback()
        raise HTTPException(status_code=500, detail=f"Database error: {str(e)}")
    finally:
        cursor.close()

@app.post('/centra/moringa_batches')
def record_moringa_batches(moringa_data: MoringaBatchesSchema):
    current_time = datetime.now()
    entryDate = datetime.strptime(moringa_data.entryDate, "%Y-%m-%d").date()
    entryTime = current_time.strftime("%H:%M:%S")
    expiry_time = current_time + timedelta(hours=4)

    cursor = mysql_connection.cursor()

    try:
        centra_name = moringa_data.centra_name

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

@app.get('/centra/moringa_batches')
def get_moringa_batches(centra_name: str):
    cursor = mysql_connection.cursor()

    try:
        # Fetch data from centra_moringa_batches table based on the centra_name
        select_query = """
            SELECT id, entryDate, entryTime, weight_received
            FROM centra_moringa_batches
            WHERE centra_name = %s
        """
        cursor.execute(select_query, (centra_name,))
        batches = cursor.fetchall()

        # Return the data as a list of dictionaries
        batch_list = [
            {
                "id": batch[0],
                "entryDate": batch[1],
                "entryTime": batch[2],
                "weight_received": batch[3]
            }
            for batch in batches
        ]

        return {"batches": batch_list}

    except mysql.connector.Error as e:
        raise HTTPException(status_code=500, detail=f"Database error: {str(e)}")

    finally:
        cursor.close()

@app.get('/centra/dried_leaves_batches')
def get_dried_leaves_batches(centra_name: str):
    cursor = mysql_connection.cursor()

    try:
        # Fetch data from centra_moringa_batches table based on the centra_name
        select_query = """
            SELECT id, date_dried, weight_dried, is_processing
            FROM centra_drying_results
            WHERE centra_name = %s
        """
        cursor.execute(select_query, (centra_name,))
        batches = cursor.fetchall()

        print(batches)

        # Return the data as a list of dictionaries
        batch_list = [
            {
                "id": batch[0],
                "date_dried": batch[1],
                "weight_dried": batch[2],
                "is_processing": batch[3],
            }
            for batch in batches
        ]

        return {"batches": batch_list}

    except mysql.connector.Error as e:
        raise HTTPException(status_code=500, detail=f"Database error: {str(e)}")

    finally:
        cursor.close()

@app.get('/all_powder_batches')
def get_powder_batches(centra_name: str):
    cursor = mysql_connection.cursor()
    try:
        # Execute SQL query to fetch powder batches
        select_query = """
            SELECT id, date_recorded, powder_weight
            FROM centra_powder_batches
            WHERE centra_name = %s
        """
        cursor.execute(select_query, (centra_name,))
        results = cursor.fetchall()

        if results:
            powder_batches = []
            for result in results:
                powder_batches.append({
                    'id': result[0],
                    'date_recorded': result[1].strftime('%Y-%m-%d'),
                    'powder_weight': result[2]
                })
            return powder_batches
        else:
            raise HTTPException(status_code=404, detail=f"No powder batches found for {centra_name}")

    except mysql.connector.Error as e:
        raise HTTPException(status_code=500, detail=f"Failed to fetch powder batches: {str(e)}")

    finally:
        cursor.close()

@app.put('/centra/moringa_batches/{batch_id}')
def update_moringa_batch(batch_id: int, update_data: MoringaBatchUpdateSchema):
    cursor = mysql_connection.cursor()

    try:
        # Check if the batch exists
        select_query = """
            SELECT * FROM centra_moringa_batches WHERE id = %s
        """
        cursor.execute(select_query, (batch_id,))
        batch = cursor.fetchone()

        if not batch:
            raise HTTPException(status_code=404, detail=f"Moringa batch with id {batch_id} not found")

        # Prepare update query based on the fields provided in the update_data
        update_fields = {}
        if update_data.entryDate:
            update_fields['entryDate'] = datetime.strptime(update_data.entryDate, "%Y-%m-%d").date()
        if update_data.weight_received is not None:
            update_fields['weight_received'] = update_data.weight_received

        if not update_fields:
            raise HTTPException(status_code=400, detail="No valid fields provided for update")

        update_query = """
            UPDATE centra_moringa_batches SET {update_values} WHERE id = %s
        """.format(update_values=", ".join([f"{field} = %s" for field in update_fields.keys()]))

        cursor.execute(update_query, tuple(update_fields.values()) + (batch_id,))
        mysql_connection.commit()

        return {"message": f"Moringa batch with id {batch_id} updated successfully"}

    except mysql.connector.Error as e:
        mysql_connection.rollback()
        raise HTTPException(status_code=500, detail=f"Failed to update moringa batch: {str(e)}")

    finally:
        cursor.close()

@app.delete('/centra/moringa_batches/all')
def delete_all_moringa_batches(request: DeleteBatchesRequest):
    centra_name = request.centra_name
    cursor = mysql_connection.cursor()

    try:
        # Delete all batches for the given centra_name
        delete_query = """
            DELETE FROM centra_moringa_batches
            WHERE centra_name = %s
        """
        cursor.execute(delete_query, (centra_name,))
        mysql_connection.commit()

        if cursor.rowcount > 0:
            return {"message": f"All batches for {centra_name} deleted successfully."}
        else:
            raise HTTPException(status_code=404, detail=f"No batches found for {centra_name}")

    except mysql.connector.Error as e:
        mysql_connection.rollback()
        raise HTTPException(status_code=500, detail=f"Failed to delete batches: {str(e)}")

    finally:
        cursor.close()

@app.delete('/centra/dried_batches')
def delete_used_dried_batches(request: DeleteBatchesRequest):
    centra_name = request.centra_name
    cursor = mysql_connection.cursor()

    try:
        # Delete all batches for the given centra_name
        delete_query = """
            DELETE FROM centra_drying_results
            WHERE centra_name = %s AND is_processing = %s
        """
        cursor.execute(delete_query, (centra_name, 1))
        mysql_connection.commit()

        if cursor.rowcount > 0:
            return {"message": f"All used batches for {centra_name} deleted successfully."}
        else:
            raise HTTPException(status_code=404, detail=f"No used  batches found for {centra_name}")

    except mysql.connector.Error as e:
        mysql_connection.rollback()
        raise HTTPException(status_code=500, detail=f"Failed to delete batches: {str(e)}")

    finally:
        cursor.close()

@app.post('/centra/drying_results')
def insert_drying_result(drying_data: DryingResultsSchema):
    cursor = mysql_connection.cursor()

    try:
        insert_query = """
            INSERT INTO centra_drying_results (centra_name, date_dried, weight_dried)
            VALUES (%s, %s, %s)
        """
        cursor.execute(insert_query, (drying_data.centra_name, drying_data.date_dried, drying_data.weight_dried))
        mysql_connection.commit()

        return {"message": "Drying result recorded successfully."}

    except mysql.connector.Error as e:
        mysql_connection.rollback()
        raise HTTPException(status_code=500, detail=f"Failed to record drying result: {str(e)}")

    finally:
        cursor.close()

@app.post('/centra/powder_results')
def insert_powder_result(powder_data: DryingResultsSchema):
    cursor = mysql_connection.cursor()

    try:
        insert_query = """
            INSERT INTO centra_powder_batches (centra_name, date_recorded, powder_weight)
            VALUES (%s, %s, %s)
        """
        cursor.execute(insert_query, (powder_data.centra_name, powder_data.date_dried, powder_data.weight_dried))
        mysql_connection.commit()

        return {"message": "Powder result recorded successfully."}

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

@app.get('/centra/powder_batch')
def get_powder_batch(centra_name: str, production_date: str):
    cursor = mysql_connection.cursor()

    try:
        # Execute SQL query to fetch dried leaves batch
        select_query = """
            SELECT id, centra_name, date_recorded, powder_weight
            FROM centra_powder_batches
            WHERE centra_name = %s AND date_recorded = %s
        """
        cursor.execute(select_query, (centra_name, production_date))
        result = cursor.fetchone()

        if result:
            powder_batch = {
                'id': result[0],
                'centra_name': result[1],
                'date_recorded': result[2].strftime('%Y-%m-%d'),
                'powder_weight': result[3]
            }
            return powder_batch
        else:
            raise HTTPException(status_code=404, detail=f"No powder batch found for {centra_name} on {production_date}")

    except mysql.connector.Error as e:
        raise HTTPException(status_code=500, detail=f"Failed to fetch powder batch: {str(e)}")

    finally:
        cursor.close()



@app.put('/update_processing')
async def update_processing(data: UpdateProcessingSchema):
    ids = data.ids
    if not ids:
        raise HTTPException(status_code=400, detail="No IDs provided")

    # Create the SQL query to update the is_processing column
    placeholders = ', '.join(['%s'] * len(ids))
    query = f"UPDATE centra_drying_results SET is_processing = 1 WHERE id IN ({placeholders})"

    cursor = mysql_connection.cursor()

    try:
        cursor.execute(query, ids)
        mysql_connection.commit()

        if cursor.rowcount == 0:
            raise HTTPException(status_code=404, detail="No rows were updated. Check if the IDs exist.")

        return {"message": f"Updated is_processing to 1 for IDs: {ids}"}

    except mysql.connector.Error as err:
        mysql_connection.rollback()
        raise HTTPException(status_code=500, detail=f"Database error: {err}")

    finally:
        cursor.close()

@app.put('/update_powder_shipping')
async def update_powder_shipping(data: UpdateProcessingSchema):
    ids = data.ids
    if not ids:
        raise HTTPException(status_code=400, detail="No IDs provided")

    # Create the SQL query to update the is_processing column
    placeholders = ', '.join(['%s'] * len(ids))
    query = f"UPDATE centra_drying_results SET is_processing = 1 WHERE id IN ({placeholders})"

    cursor = mysql_connection.cursor()

    try:
        cursor.execute(query, ids)
        mysql_connection.commit()

        if cursor.rowcount == 0:
            raise HTTPException(status_code=404, detail="No rows were updated. Check if the IDs exist.")

        return {"message": f"Updated is_processing to 1 for IDs: {ids}"}

    except mysql.connector.Error as err:
        mysql_connection.rollback()
        raise HTTPException(status_code=500, detail=f"Database error: {err}")

    finally:
        cursor.close()




@app.post('/centra/shipments')
async def record_shipment(shipment_data: ShipmentSchema, current_user: dict = Depends(get_current_user)):
    powder_batch_id = shipment_data.powder_batch_id
    package_weight = shipment_data.package_weight
    total_package = shipment_data.total_package
    centra_sender = shipment_data.centra_sender
    sender_address = shipment_data.sender_address
    recever_address = shipment_data.receiver_address
    expedition = shipment_data.expedition
    date_shipped = shipment_data.date_shipped

    # Generate barcode
    barcode_value = f"{date_shipped}-{expedition}-{total_package}"
    barcode_filename = f"barcode_{date_shipped}_{expedition}_{total_package}.png"
    barcode_image_path = os.path.join(barcode_directory, barcode_filename)
    generate_barcode(barcode_value, barcode_image_path)

    cursor = mysql_connection.cursor()
    insert_query = """
        INSERT INTO centra_shipments (powder_batch_id, package_weight, total_package, centra_sender, sender_address, receiver_address, expedition, date_shipped, barcode)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
    """

    try:
        cursor.execute(insert_query, (powder_batch_id, package_weight, total_package, centra_sender, sender_address, recever_address, expedition, date_shipped, barcode_image_path))
        mysql_connection.commit()

        return {"message": "Shipment added"}

    except mysql.connector.Error as err:
        mysql_connection.rollback()
        raise HTTPException(status_code=500, detail=f"Database error: {err}")
    
    finally:
        cursor.close()





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
async def scan_barcode(barcode_string: str):
    # Decode the barcode string
    try:
        decoded_objects = decode(barcode_string.encode('utf-8'))
    except Exception as e:
        raise HTTPException(status_code=400, detail=f"Error decoding barcode: {str(e)}")

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
