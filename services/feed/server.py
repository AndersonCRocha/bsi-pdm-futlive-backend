from flask import Flask, request, jsonify
import mysql.connector as mysql

app = Flask(__name__)

MYSQL_SERVER = "database"
MYSQL_USER = "root"
MYSQL_PASSWORD = "admin"
MYSQL_DATABASE = "futlive"

def getConnection() :
  return mysql.connect(
    host=MYSQL_SERVER, user=MYSQL_USER, password=MYSQL_PASSWORD, database=MYSQL_DATABASE
  )

@app.route("/")
def index():
  return "Feed service"

@app.route("/feeds")
def getAll():
  page = request.args.get('page') or 0
  
  connection = getConnection()
  cursor = connection.cursor(dictionary=True)
  
  cursor.execute(f"""
    SELECT * FROM games             
  """)
    
  return jsonify(cursor.fetchall())

if __name__ == '__main__':
  app.run(
    host="0.0.0.0",
    port="5000",
    debug=True
  )