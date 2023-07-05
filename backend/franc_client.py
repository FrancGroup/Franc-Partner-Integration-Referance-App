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
    response = session.post(base_url + "/oauth2/token", data={
        "grant_type": "password",
        "username": username,
        "password": password
    })
    return response.json()["access_token"]


def get_breakout_url(user_id: str, redirect_url: str):
    token = get_token()
    response = requests.get(base_url + f"/ui/get-breakout-url?external_user_id={user_id}&redirect_url={redirect_url}",
                             headers={"Authorization": f"Bearer {token}"})
    return response.json()["url"]
