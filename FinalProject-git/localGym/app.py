from flask import Flask, render_template
from flask import request, redirect
from db_connector.db_connector import connect_to_database, execute_query

app = Flask(__name__)

@app.route('/class')
def class():
    db_connection = connect_to_database()
    query = "SELECT class_name, class_date, class_time, room, (SELECT instructor.first_name FROM instructor INNER JOIN class ON instructor.instructor_ID=class.instructor_ID);"
    result = execute_query(db_connection, query).fetchall();
    return render_template('schedule_class.html', rows=result)
