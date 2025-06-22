from flask import Flask, request, jsonify
import mysql.connector
from mysql.connector import Error
import logging
from langchain_community.embeddings import OllamaEmbeddings
from langchain_community.llms import Ollama
from langchain.vectorstores import Chroma
from langchain.chains import RetrievalQA
import os

app = Flask(__name__)

# === RAG Setup ===
VECTOR_DB_PATH = "./vector_store"  # same path used in embedder.py

embeddings = OllamaEmbeddings(model="nomic-embed-text")
vectordb = Chroma(persist_directory=VECTOR_DB_PATH, embedding_function=embeddings)
retriever = vectordb.as_retriever()
llm = Ollama(model="llama3")
qa_chain = RetrievalQA.from_chain_type(llm=llm, retriever=retriever)

@app.route('/ask', methods=['POST'])
def ask_chatbot():
    data = request.get_json()
    user_query = data.get('question')

    if not user_query:
        return jsonify({"error": "No question provided"}), 400

    try:
        response = qa_chain.run(user_query)
        return jsonify({"response": response})
    except Exception as e:
        return jsonify({"error": str(e)}), 500

# === SOS App Logic (unchanged) ===

@app.route('/')
def home():
    return "Welcome to the SOS App API!"

def create_connection():
    try:
        return mysql.connector.connect(
            host="localhost",
            user="root",
            password="ashkook.......",
            database="sosappnew"
        )
    except Error as e:
        print("Error while connecting to MySQL", e)
        return None

@app.route('/contacts', methods=['POST'])
def add_contact():
    data = request.get_json()
    name, phone = data.get('name'), data.get('phone')
    if not name or not phone:
        return jsonify({"error": "Name and phone are required"}), 400

    connection = create_connection()
    if not connection:
        return jsonify({"error": "Failed to connect to the database"}), 500

    cursor = connection.cursor()
    cursor.execute("INSERT INTO contacts (name, phone) VALUES (%s, %s)", (name, phone))
    connection.commit()
    cursor.close()
    connection.close()

    return jsonify({"message": "Contact added", "id": cursor.lastrowid}), 201

@app.route('/contacts', methods=['GET'])
def get_contacts():
    connection = create_connection()
    if not connection:
        return jsonify({"error": "Failed to connect to the database"}), 500

    cursor = connection.cursor()
    cursor.execute("SELECT * FROM contacts")
    results = cursor.fetchall()
    cursor.close()
    connection.close()

    contacts = [{"id": row[0], "name": row[1], "phone": row[2]} for row in results]
    return jsonify(contacts)

@app.route('/medications', methods=['POST'])
def add_medication():
    data = request.get_json()
    name, dosage, time = data.get('name'), data.get('dosage'), data.get('time')
    if not name or not dosage or not time:
        return jsonify({"error": "Name, dosage, and time are required"}), 400

    connection = create_connection()
    if not connection:
        return jsonify({"error": "Failed to connect to the database"}), 500

    cursor = connection.cursor()
    cursor.execute("INSERT INTO medications (name, dosage, time) VALUES (%s, %s, %s)", (name, dosage, time))
    connection.commit()
    cursor.close()
    connection.close()

    return jsonify({"message": "Medication added", "id": cursor.lastrowid}), 201

@app.route('/medications', methods=['GET'])
def get_medications():
    connection = create_connection()
    if not connection:
        return jsonify({"error": "Failed to connect to the database"}), 500

    cursor = connection.cursor()
    cursor.execute("SELECT * FROM medications")
    results = cursor.fetchall()
    cursor.close()
    connection.close()

    medications = [{"id": row[0], "name": row[1], "dosage": row[2], "time": row[3]} for row in results]
    return jsonify(medications)

@app.route('/test-db', methods=['GET'])
def test_db():
    connection = create_connection()
    if not connection:
        return jsonify({"error": "Failed to connect to the database"}), 500

    try:
        cursor = connection.cursor()
        cursor.execute("SELECT 1")
        return jsonify({"message": "Database connection is successful!"}), 200
    except Error as e:
        return jsonify({"error": f"MySQL Error: {str(e)}"}), 500
    finally:
        cursor.close()
        connection.close()

# === Run Server ===
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
    logging.info("Server is running on http://localhost:5000")
