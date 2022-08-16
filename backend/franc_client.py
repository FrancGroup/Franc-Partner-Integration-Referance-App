import os

import requests

username = os.getenv("franc_username", "kyle2")
password = os.getenv("franc_password", "kyle2")
client_id = os.getenv("franc_client_id", "iEOtIfQVh7OvBVaZV4LazMyj")
client_secret = os.getenv("franc_client_secret", "jQQ7cbsuLzbyIUny8XmfRjjE7ZDAEkvWNtj81zPNftYwMzf9")
base_url = "https://test.partners.franc.app"


def get_token():
    session = requests.Session()
    session.auth = (client_id, client_secret)
    response = session.post("https://test.partners.franc.app/oauth2/token", data={
        "grant_type": "password",
        "username": username,
        "password": password
    })
    return response.json()["access_token"]


def get_breakout_url():
    token = get_token()
    response = requests.post(base_url+"/ui/get-breakout-url", headers={"Authorization": f"Bearer {token}"}, json={})
    return ("https://1de6-196-11-156-123.eu.ngrok.io"+response.json()["url"][response.json()["url"].index("/register")::])

print(get_breakout_url())

