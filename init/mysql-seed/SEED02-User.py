import csv
import mysql.connector
import os
import uuid

db_connection = mysql.connector.connect(
    host='mysql-db',
    port='3306', 
    user='root',
    password= os.getenv('MYSQL_ROOT_PASSWORD'),  
    database=os.getenv('MYSQL_DATABASE')
)

current_directory = os.getcwd()
csv_file_path = os.path.join(current_directory, 'csv', 'user.csv')

cursor = db_connection.cursor()

with open(csv_file_path, 'r') as file:
    csv_data = csv.reader(file)
    next(csv_data)

    query = "INSERT INTO user (UserID, FirstName, LastName, Email, Password, Role, Gender, MobileNumber, LastLogin, StudentID, ProfilePictureID, MFA_QR, MFA_Secret) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"
    values = []


    for row in csv_data:
        userIDd_str = row[0]
        userID_obj = uuid.UUID(userIDd_str)
        UserID = userID_obj.bytes
        FirstName = row[1]
        LastName = row[2]
        Email = row[3]
        Password = row[4]
        Role = row[5]
        Gender = row[6]
        MobileNumber = row[7]
        LastLogin = None
        StudentID = row[9]
        propicIDd_str = row[10]
        propicID_obj = uuid.UUID(propicIDd_str)
        ProfilePictureID = propicID_obj.bytes
        MFA_QR = row[11]
        MFA_Secret = row[12]
        

        values.append((UserID, FirstName, LastName, Email, Password, Role, Gender, MobileNumber, LastLogin, StudentID, ProfilePictureID, MFA_QR, MFA_Secret))


    try:
        cursor.executemany(query, values)

    except mysql.connector.Error as error:
        print(f"Error transferring data: {error}")

db_connection.commit()
cursor.close()
db_connection.close()
