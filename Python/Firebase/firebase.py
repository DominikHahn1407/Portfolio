import os
import firebase_admin
from firebase_admin import credentials, firestore

from dotenv import load_dotenv

load_dotenv()
SERVICE_ACCOUNT_JSON_PATH = os.getenv("SERVICE_ACCOUNT_JSON_PATH")

cred = credentials.Certificate(SERVICE_ACCOUNT_JSON_PATH)
firebase_admin.initialize_app(cred)

db = firestore.client()

data = {
    'task_title': 'Do the Dishes',
    'task_status': 'TODO',
}

doc_ref = db.collection('tasks_collection').document()
doc_ref.set(data)

print(f'Document ID: {doc_ref.id}')