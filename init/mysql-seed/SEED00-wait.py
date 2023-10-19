import mysql.connector
import time
import os

def wait_for_mysql():
    while True:
        try:
            conn = mysql.connector.connect(
                host='mysql-db',
                port='3306', 
                user='root',
                password= os.getenv('MYSQL_ROOT_PASSWORD'),  
                database=os.getenv('MYSQL_DATABASE')
            )
            conn.close()
            return
        except mysql.connector.Error as e:
            print('Could not connect to MySQL, retrying in 5 seconds...')
            time.sleep(5)

wait_for_mysql()