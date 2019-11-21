from flask import Flask, render_template
from flask import request, redirect
from db_connector.db_connector import connect_to_database, execute_query
webapp = Flask(__name__)


@webapp.route('/hello')
#provide a view (fancy name for a function) which responds to any requests on this route
def hello():
    return "Hello World!";

@webapp.route('/classes')
#the name of this function is just a cosmetic thing
def classes():
    db_connection = connect_to_database()
    query = "SELECT class_name, class_date, class_time, room, instructor_ID) from class;"
    result = execute_query(db_connection, query).fetchall();
    print(result)
    return render_template('schedule_class.html', classes=result)

@webapp.route('/add_class', methods=['POST','GET'])
def add_new_people():
    db_connection = connect_to_database()
    if request.method == 'GET':
        query = 'SELECT instructor_ID, first_name, last_name from instructor'
        result = execute_query(db_connection, query).fetchall();
        print(result)

        return render_template('add_class.html', instructor = result)
    elif request.method == 'POST':
        class_name = request.form['class_name']
        class_date = request.form['class_date']
        class_time = request.form['class_time']
        room = request.form['room']
        instructor_first_name = request.form['instructor_first_name']
        instructor_last_name = request.form['instructor_last_name']

        query = 'INSERT INTO class (class_name, class_date, class_time, room, instructor_ID) VALUES (%s,%s,%s,%s,%s)'
        data = (class_name, class_date, class_time, room, instructor_ID)
        execute_query(db_connection, query, data)
        return ('Class added!');
