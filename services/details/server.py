from flask import Flask, request, jsonify
import mysql.connector as mysql

app = Flask(__name__)

IS_ALIVE = True
MYSQL_SERVER = "database"
MYSQL_USER = "root"
MYSQL_PASSWORD = "admin"
MYSQL_DATABASE = "futlive"

def getConnection() :
  return mysql.connect(
    host=MYSQL_SERVER, user=MYSQL_USER, password=MYSQL_PASSWORD, database=MYSQL_DATABASE, charset='utf8'
  )

def generateGameDetail(game):
    return {
      "id": game['id'],
      "stadium" : game['stadium'],
      "round" : game['round'],
      "date": game['date'],
      "championship": {
        "name": game['championship_name'],
        "numberOfRounds": game['championship_rounds'] 
      },
      "homeTeam": {
        "id": game['home_team_id'],
        "name": game['home_team_name'],
        "classification": game['home_classification'],
        "shield": game['home_team_shield'],
        "goals": game['home_team_goals'],
      },
      "visitingTeam": {
        "id": game['visiting_team_id'],
        "name": game['visiting_team_name'],
        "classification": game['visiting_classification'],
        "shield": game['visiting_team_shield'],
        "goals": game['visiting_team_goals'],
      }
    }

@app.route("/")
def index():
  if not IS_ALIVE:
    return "Service temporarily unavailable"
  
  return "Details service"

@app.route("/is-alive")
def isALive():
  return jsonify(IS_ALIVE)

@app.route("/game-details/<int:gameId>")
def getAll(gameId):
  if not IS_ALIVE:
    return "Service temporarily unavailable"
  
  connection = getConnection()
  cursor = connection.cursor(dictionary=True)
  
  cursor.execute(f"""
    SELECT
      g.id AS id,
      g.stadium AS stadium,
      g.round AS round,
      tc_home.classification AS home_classification,
      tc_visiting.classification AS visiting_classification,
      champ.name AS championship_name,
      champ.number_of_rounds AS championship_rounds,
      DATE_FORMAT(g.date, '%Y-%m-%d %T') AS date,
      g.home_team_goals AS home_team_goals,
      g.visiting_team_goals AS visiting_team_goals,
      team_home.id AS home_team_id,
      team_home.name AS home_team_name,
      team_visiting.id AS visiting_team_id,
      team_visiting.name AS visiting_team_name,
      team_home.shield AS home_team_shield,
      team_visiting.shield AS visiting_team_shield
    FROM games AS g
    JOIN championships champ
      ON champ.id = g.championship_id
    JOIN team_championship tc_home 
      ON tc_home.team_id = g.home_team_id
    JOIN teams team_home 
      ON team_home.id = tc_home.team_id 
    JOIN team_championship tc_visiting
      ON tc_visiting.team_id = g.visiting_team_id 
    JOIN teams team_visiting 
      ON team_visiting.id = tc_visiting.team_id
    WHERE g.id = {gameId}
  """)
  game = cursor.fetchone()
  
  return jsonify(generateGameDetail(game))

if __name__ == '__main__':
  app.run(
    host="0.0.0.0",
    port="5001",
    debug=True
  )