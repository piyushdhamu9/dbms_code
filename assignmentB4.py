# MongoDB Database Connectivity using Python (pymongo library)

from pymongo import MongoClient

# Establish connection to MongoDB
client = MongoClient('mongodb://localhost:27017/')

# Select the database
db = client['your_database']  # Replace 'your_database' with actual database name

# Select the 'student' collection
collection = db['student']

# Function to add a student
def add_student(student):
    collection.insert_one(student)
    print("Student added:", student)

# Function to delete a student by student_id
def delete_student(student_id):
    result = collection.delete_one({"_id": student_id})
    if result.deleted_count > 0:
        print(f"Student with _id {student_id} deleted.")
    else:
        print("No student found with that _id.")

# Function to update a student's details
def update_student(student_id, new_values):
    result = collection.update_one({"_id": student_id}, {"$set": new_values})
    if result.modified_count > 0:
        print(f"Student with _id {student_id} updated.")
    else:
        print("No student found with that _id.")

# Function to fetch and display all students
def display_students():
    for student in collection.find():
        print(student)

# Example usage
new_student = {"name": "John Doe", "roll_no": 1, "address": "New York"}
add_student(new_student)

# Fetch all records
print("All Students:")
display_students()

# Update a student
update_student(1, {"name": "John Smith"})

# Delete a student
delete_student(1)

# Close the MongoDB connection
client.close()
