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
csv_file_path = os.path.join(current_directory, 'csv', 'file.csv')

cursor = db_connection.cursor()

with open(csv_file_path, 'r') as file:
    csv_data = csv.reader(file)
    next(csv_data)

    query = "INSERT INTO file (FileID, OriginalFileName, FileSize) VALUES (%s, %s, %s)"
    values = []


    for row in csv_data:
        uuid_str = row[0]
        uuid_obj = uuid.UUID(uuid_str)
        FileID = uuid_obj.bytes
        OriginalFileName = row[1]
        FileSize = int(row[2]) 

        values.append((FileID, OriginalFileName,FileSize))


    try:
        cursor.executemany(query, values)

    except mysql.connector.Error as error:
        print(f"Error transferring data: {error}")

db_connection.commit()
cursor.close()
db_connection.close()
