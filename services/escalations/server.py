from flask import Flask, jsonify
import mysql.connector as mysql

app = Flask(__name__)

MYSQL_SERVER = "database"
MYSQL_USER = "root"
MYSQL_PASSWORD = "admin"
MYSQL_DATABASE = "futlive"

def getConnection() :
  return mysql.connect(
    host=MYSQL_SERVER, user=MYSQL_USER, password=MYSQL_PASSWORD, database=MYSQL_DATABASE, charset='utf8'
  )

def generatePlayerList(players):
  formattedPlayers = []
  
  for player in players:
    formattedPlayers.append({
      "name": player['name'],
      "position": player['position'],
      "number": player['number'],
    })
  
  return formattedPlayers

@app.route("/")
def index():
  return "Escalations service"

@app.route("/escalation/<int:teamId>")
def getAll(teamId):
  connection = getConnection()
  cursor = connection.cursor(dictionary=True)
  
  cursor.execute(f"""
    SELECT t.name AS name
    FROM teams AS t
    WHERE t.id = {teamId}
  """)
  teamNameResult = cursor.fetchone()
  
  cursor.execute(f"""
    SELECT
      p.name AS name,
      p.position AS position,
      p.number AS number
    FROM players AS p
    WHERE p.team_id = {teamId}
      AND p.is_scaled = 1
  """)
  players = cursor.fetchall()
  
  return jsonify({
    "teamName": teamNameResult['name'],
    "escalation": generatePlayerList(players)
  })

if __name__ == '__main__':
  app.run(
    host="0.0.0.0",
    port="5002",
    debug=True
  )