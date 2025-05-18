import pyodbc

conn = pyodbc.connect("DRIVER={SQL Server};SERVER=localhost\\SQLEXPRESS;DATABASE=YourDB;Trusted_Connection=yes;")
cursor = conn.cursor()

cursor.execute("SELECT image FROM photos WHERE id = 1")
row = cursor.fetchone()

with open("output.jpg", "wb") as f:
    f.write(row[0])
