import os
import sendgrid
from sendgrid.helpers.mail import Mail
from flask import Flask, request

app = Flask(__name__)

@app.route('/send_email', methods=['POST'])
def send_email():
    sg = sendgrid.SendGridAPIClient(api_key=os.getenv('SENDGRID_API_KEY'))
    email = Mail(
        from_email='your-email@example.com',
        to_emails='recipient@example.com',
        subject='V2C Email Notification',
        html_content='<strong>Hello from GCP!</strong>'
    )
    response = sg.send(email)
    return {"status": response.status_code}

if __name__ == '__main__':
    app.run()
