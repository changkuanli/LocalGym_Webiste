--Data Manipulation File

--Class Manipulation
--Delete class
DELETE FROM class WHERE class_id = :class_id_from_text_entry;

-- UPDATE Class
UPDATE class
SET class_name = :new_class_name,
 class_date = :new_class_date,
 class_time = :new_class_time,
 room = :new_room, 
WHERE class_ID = :class_ID AND instructor_ID = :instructor_ID

--Manage class
SELECT * FROM class

--Add Class
INSERT INTO class (class_name, class_date, class_time, room) 
VALUES (:new_class_name, :new_class_date :new_class_time, :new_room);

--Query to populate the class list
SELECT class FROM class;


--Instructor Manipulation
--Add Instructor
INSERT INTO instructor (first_name, last_name)
VALUES (:new_first_name, :new_last_name);

--Delete instructor
DELETE FROM instructor WHERE instructor_ID = :instructor_ID_from_text_entry;



--Member Manipulation
--Add Member
INSERT INTO member(first_name, last_name, email, gender)
VALUES (:new_first_name, :new_last_name, :new_email, :new_gender);

--Delete member
DELETE FROM member WHERE member_ID = :member_ID_from_text_entry;

