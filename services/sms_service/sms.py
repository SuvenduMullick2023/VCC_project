import os
from flask import Flask, request
from twilio.rest import Client

app = Flask(__name__)

@app.route('/send_sms', methods=['POST'])
def send_sms():
    account_sid = os.getenv('TWILIO_SID')
    auth_token = os.getenv('TWILIO_AUTH_TOKEN')
    client = Client(account_sid, auth_token)

    message = client.messages.create(
        body="Test SMS from GCP V2C.",
        from_='+1234567890',  # Twilio number
        to='+0987654321'      # Destination number
    )

    return {"message_sid": message.sid}

if __name__ == '__main__':
    app.run()
