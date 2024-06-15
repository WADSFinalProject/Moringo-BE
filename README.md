# fastapidsd [FAST API DEEP SEA DIVERS]

Signup and Logins fully work, with the logic of Admin approvals for user signups.

## User Signups

User signups accept the parameters: `username`, `email`, `password`,`user_role`, `country code`, `phone number`, `first name`, and `last name`. These parameters will be stored in the MySQL database, and the credentials will be sent to the admin's email for approval. At this stage, the account is not yet created in Firebase.

## User Logins

User logins accept the parameters: `email` and `password`. After a successful login, it will return a token for the current user session.

## Admin Approval Logic

The admin has an approval endpoint (`/admin/approve/{email}/{decision}`) in the backend, which accepts the parameters: `email` and `decision`. 

- `email`: The target email to decide the fate of.
- `decision`: The decision to approve or reject the signup. This should be either "yes" or "no".

If the decision is "yes", the account will be created in Firebase, allowing the user to log in. If the decision is "no", the account credentials will be deleted from the MySQL database, as if the signup request never happened.


## IMPORTANT NOTE FOR IMPORTS!!!
DO NOT 
pip install pyrebase

it never works... i tried on two laptops and it just never does.

INSTEAD DO 





pip install pycryptodome 



pip install pyrebase4



now dat works.

## QUESTIONS?
I'm mostly active on Whatsapp, message me anytime for any kind of questions regarding the backends, or if you have a suggestion in improvements or restructuring (harman).


## WHAT HAPPENED IN 1989?
Nothing
