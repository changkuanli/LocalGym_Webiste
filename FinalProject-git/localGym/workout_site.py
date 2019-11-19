import os
from flask import Flask, render_template
from flask import request
from db_connector.db_connector import connect_to_database, execute_query
app = Flask(_name_)


class table:
	headers = []
	data = []

memberTable = table()
memberTable.headers = ["Member ID", "First Name", "Last Name", "Email", "Gender"]

instructorTable = table()
instructor.headers = ["Instructor ID", "First Name", "Last Name"]

classTable = table()
classTable.headers = ["Class  ID", "Instructor ID", "Class Name", "Class Date", "Class Time", "Room"]

member_classTable = table()
member_classTable.headers = ["Member Class ID", "Member ID", "Class ID"]


@app.route('/members', methods=['GET'])
def members():

	db_connection = connect_to_database()
	query = "SELECT member_ID, first_name, last_name, email, gender"
	result = execute_query(db_connection, query).fetchall();
	return render_template('members.html', SELECT_member_Rows = result)



@app.route('/instructors', methods=['GET'])
def members():

	db_connection = connect_to_database()
	query = "SELECT instructor_ID, first_name, last_name"
	result = execute_query(db_connection, query).fetchall();
	return render_template('instructors.html', SELECT_instructors_Rows = result)#need index page


@app.route('/classes', methods=['GET'])
def classes():
	db_connection = connect_to_database()
	query = "SELECT class_ID, instructor_ID, class_name, class_date, class_time, room"
	result = execute_query(db_connection, query).fetchall();
	return render_template('classes.html', SELECT_Class_Rows = result)#need index page


@app.route('/cert', methods=['GET'])
def certs():

	db_connection = connect_to_database()
	query = "SELECT cert_ID"
	result = execute_query(db_connection, query).fetchall();
	return render_template('certs.html', SELECT_cert_Rows = result)#need index page

@app.route('/instructor_cert', methods=['GET'])
def instructor_certs():

	db_connection = connect_to_database()
	query = "SELECT instructor_cert_ID, instructor_ID, cert_ID"
	result = execute_query(db_connection, query).fetchall();
	return render_template('instructor_certs.html', SELECT_certs_Rows = result)#need index page

@app.route('/addclass', methods=['POST'])
def addclass():
	db_connection = connect_to_database()
	request.method == 'POST':
	class_ID = request.form['input_class_ID']
	class_name = request.form['input_class_name']
	class_date = request.form['input_class_date']
	class_time = request.form['input_class_time']
	room = request.form['input_room']
	query = "INSERT INTO class(class_ID, class_name, class_date, class_time, input_room) VALUES (%s, %s, %s, %s, %s);"
	data = (class_ID, class_name, class_date, class_time, input_room)
	execute_query(db_connection, query, data)
	query = "SELECT class_ID, class_name, class_date, class_time, room"
	result = execute_query(db_connection, query).fetchall();
	return render_template('addclasses.html', SELECT_class_rows = result)#need index page


@app.route('/addmember', methods=['POST'])
def addmember():
	db_connection = connect_to_database()
	request.method == 'POST':
	member_ID = request.form['member_ID']
	first_name = request.form['input_first_name']
	last_name = request.form['input_last_name']
	email = request.form['input_email']
	gender = request.form['input_gender']
	query = "INSERT INTO member(member_ID, first_name, last_name, email, gender) VALUES (%s, %s, %s, %s, %s);"
	data = (member_ID, first_name, last_name, email, gender)
	execute_query(db_connection, query, data)
	query = "SELECT member_ID, first_name, last_name, email, gender"
	result = execute_query(db_connection, query).fetchall();
	return render_template('addmember.html', SELECT_add_class_rows = result)#need index page


@app.route('/addinstructor', methods=['POST'])
def addinstructor():
	db_connection = connect_to_database()
	request.method == 'POST':
	instructor_ID = request.form['instructor_ID']
	first_name = request.form['input_first_name']
	last_name = request.form['input_last_name']
	query = "INSERT INTO member(member_ID, first_name, last_name) VALUES (%s, %s, %s);"
	data = (member_ID, first_name, last_name)
	execute_query(db_connection, query, data)
	query = "SELECT member_ID, first_name, last_name"
	result = execute_query(db_connection, query).fetchall();
	return render_template('addinstructor.html', SELECT_add_instructor_rows = result) #need index page