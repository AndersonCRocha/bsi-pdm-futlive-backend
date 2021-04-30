from flask import Flask, request, jsonify
import mysql.connector as mysql

app = Flask(__name__)

IS_ALIVE = True
MYSQL_SERVER = "database"
MYSQL_USER = "root"
MYSQL_PASSWORD = "admin"
MYSQL_DATABASE = "futlive"
PER_PAGE = 3

def getConnection() :
  return mysql.connect(
    host=MYSQL_SERVER, user=MYSQL_USER, password=MYSQL_PASSWORD, database=MYSQL_DATABASE, charset='utf8'
  )

def generateFeedItem(feed):
  formattedFeed = []
  
  for item in feed:
    formattedFeed.append({
      "id": item['id'],
      "date": item['date'],
      "homeTeam": {
        "name": item['home_team_name'],
        "shield": item['home_team_shield'],
        "goals": item['home_team_goals'],
      },
      "visitingTeam": {
        "name": item['visiting_team_name'],
        "shield": item['visiting_team_shield'],
        "goals": item['visiting_team_goals'],
      }
    })
  
  return formattedFeed

@app.route("/")
def index():
  if not IS_ALIVE:
    return "Service temporarily unavailable"
  
  return "Feed service"

@app.route("/is-alive")
def isALive():
  return jsonify(IS_ALIVE)

@app.route("/feed-total")
def getTotalGames():
  if not IS_ALIVE:
    return "Service temporarily unavailable"
  
  connection = getConnection()
  cursor = connection.cursor(dictionary=True)
  
  cursor.execute(f"""
    SELECT COUNT(*) AS total
    FROM games
  """)
  games = cursor.fetchone()
  
  return jsonify(games['total'])
  
@app.route("/feed")
def getAll():
  if not IS_ALIVE:
    return "Service temporarily unavailable"
  
  page = int(request.args.get('page')) if request.args.get('page') else 1
  offset = (page - 1) * PER_PAGE
  
  connection = getConnection()
  cursor = connection.cursor(dictionary=True)
  
  cursor.execute(f"""
    SELECT
      g.id AS id,
      DATE_FORMAT(g.date, '%Y-%m-%d %T') AS date,
      g.home_team_goals AS home_team_goals,
      g.visiting_team_goals AS visiting_team_goals,
      team_home.name AS home_team_name,
      team_visiting.name AS visiting_team_name,
      team_home.shield AS home_team_shield,
      team_visiting.shield AS visiting_team_shield
    FROM games AS g
    JOIN team_championship tc_home 
      ON tc_home.team_id = g.home_team_id
    JOIN teams team_home 
      ON team_home.id = tc_home.team_id 
    JOIN team_championship tc_visiting
      ON tc_visiting.team_id = g.visiting_team_id 
    JOIN teams team_visiting 
      ON team_visiting.id = tc_visiting.team_id
    ORDER BY date DESC
    LIMIT {offset}, {PER_PAGE}           
  """)
  feed = cursor.fetchall()
  
  return jsonify(generateFeedItem(feed))

if __name__ == '__main__':
  app.run(
    host="0.0.0.0",
    port="5000",
    debug=True
  )