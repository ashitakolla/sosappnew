from flask import Flask, request, jsonify
import mysql.connector
from mysql.connector import Error
import logging

app = Flask(__name__)

# Root route for the home page
@app.route('/')
def home():
    return "Welcome to the SOS App API!"

# Function to create a new database connection
def create_connection():
    try:
        connection = mysql.connector.connect(
            host="localhost",
            user="root",  # Replace with your database username
            password="ashkook.......",  # Replace with your database password
            database="sosappnew"  # Replace with your database name
        )
        if connection.is_connected():
            return connection
    except Error as e:
        print("Error while connecting to MySQL", e)
        return None

# Add contact route
@app.route('/contacts', methods=['POST'])
def add_contact():
    data = request.get_json()
    name = data.get('name')
    phone = data.get('phone')

    # Check if name and phone are provided
    if not name or not phone:
        return jsonify({"error": "Name and phone are required"}), 400

    # Connect to the database
    connection = create_connection()
    if not connection:
        return jsonify({"error": "Failed to connect to the database"}), 500

    cursor = connection.cursor()
    query = "INSERT INTO contacts (name, phone) VALUES (%s, %s)"
    cursor.execute(query, (name, phone))
    connection.commit()

    # Close cursor and connection
    cursor.close()
    connection.close()

    return jsonify({"message": "Contact added successfully", "id": cursor.lastrowid}), 201

# Get all contacts route
@app.route('/contacts', methods=['GET'])
def get_contacts():
    # Connect to the database
    connection = create_connection()
    if not connection:
        return jsonify({"error": "Failed to connect to the database"}), 500

    cursor = connection.cursor()
    query = "SELECT * FROM contacts"
    cursor.execute(query)
    results = cursor.fetchall()

    # Convert the results to a list of dictionaries
    contacts = [{"id": row[0], "name": row[1], "phone": row[2]} for row in results]

    # Close cursor and connection
    cursor.close()
    connection.close()

    return jsonify(contacts)

# Add medication route
@app.route('/medications', methods=['POST'])
def add_medication():
    data = request.get_json()
    name = data.get('name')
    dosage = data.get('dosage')  # Get dosage from the request
    time = data.get('time')

    # Check if name, dosage, and time are provided
    if not name or not dosage or not time:
        return jsonify({"error": "Name, dosage, and time are required"}), 400

    # Connect to the database
    connection = create_connection()
    if not connection:
        return jsonify({"error": "Failed to connect to the database"}), 500

    cursor = connection.cursor()
    query = "INSERT INTO medications (name, dosage, time) VALUES (%s, %s, %s)"
    cursor.execute(query, (name, dosage, time))
    connection.commit()

    # Close cursor and connection
    cursor.close()
    connection.close()

    return jsonify({"message": "Medication added successfully", "id": cursor.lastrowid}), 201

# Get all medications route
@app.route('/medications', methods=['GET'])
def get_medications():
    # Connect to the database
    connection = create_connection()
    if not connection:
        return jsonify({"error": "Failed to connect to the database"}), 500

    cursor = connection.cursor()
    query = "SELECT * FROM medications"
    cursor.execute(query)
    results = cursor.fetchall()

    # Convert the results to a list of dictionaries with specified key order
    medications = [{"id": row[0], "name": row[1], "dosage": row[2], "time": row[3]} for row in results]

    # Close cursor and connection
    cursor.close()
    connection.close()

    return jsonify(medications)

# Test database connection route
@app.route('/test-db', methods=['GET'])
def test_db():
    connection = create_connection()
    if not connection:
        return jsonify({"error": "Failed to connect to the database"}), 500

    try:
        # Execute a simple query to test the connection
        cursor = connection.cursor()
        cursor.execute("SELECT 1")
        return jsonify({"message": "Database connection is successful!"}), 200
    except Error as e:
        return jsonify({"error": f"Error while connecting to MySQL: {str(e)}"}), 500
    finally:
        if connection.is_connected():
            cursor.close()
            connection.close()

# Start the server
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
    logging.info("Server is running on http://192.168.142.249:5000")
