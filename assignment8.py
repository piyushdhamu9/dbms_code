import mysql.connector

# Establish a connection to the MySQL database
connection = mysql.connector.connect(
    host="localhost",
    user="your_username",        # Replace with your MySQL username
    password="your_password",    # Replace with your MySQL password
    database="your_database"     # Replace with your database name
)

if connection.is_connected():
    print("Connected to MySQL database")

    # Create a cursor object
    cursor = connection.cursor()

    # Create Students Table with City column
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS Students (
        Roll_no INT PRIMARY KEY,
        Name VARCHAR(50),
        City VARCHAR(50)
    )
    """)

    # Insert Sample Data into Students Table
    students = [
        (1, "Alice", "New York"),
        (2, "Bob", "Los Angeles"),
        (3, "Charlie", "Chicago"),
        (4, "Diana", "Houston")
    ]
    cursor.executemany("INSERT INTO Students (Roll_no, Name, City) VALUES (%s, %s, %s)", students)
    connection.commit()
    print("Sample data inserted into Students table successfully")

    # Read data from Students table
    select_query = "SELECT * FROM Students"
    cursor.execute(select_query)
    records = cursor.fetchall()
    print("Data from Students table:")
    for row in records:
        print(row)

    # Update data in Students table
    update_query = "UPDATE Students SET Name = %s, City = %s WHERE Roll_no = %s"
    cursor.execute(update_query, ("John Doe", "San Francisco", 1))  # Example: Updating student with Roll_no 1
    connection.commit()
    print("Data updated in Students table successfully")

    # Read data again to verify update
    cursor.execute(select_query)
    updated_records = cursor.fetchall()
    print("Updated data from Students table:")
    for row in updated_records:
        print(row)

    # Delete data from Students table
    delete_query = "DELETE FROM Students WHERE Roll_no = %s"
    cursor.execute(delete_query, (1,))  # Example: Deleting student with Roll_no 1
    connection.commit()
    print("Data deleted from Students table successfully")

    # Read data again to verify deletion
    cursor.execute(select_query)
    final_records = cursor.fetchall()
    print("Final data from Students table after deletion:")
    for row in final_records:
        print(row)

    # Close the cursor and connection
    cursor.close()
    connection.close()
    print("MySQL connection closed")
else:
    print("Failed to connect to MySQL database")
