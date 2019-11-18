DROP TABLE IF EXISTS `member`;
CREATE TABLE `member`(
  `member_ID` INT(11) NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(255) NOT NULL,
  `last_name` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `gender` VARCHAR(12) NOT NULL,
  PRIMARY KEY(`member_ID`),
  CONSTRAINT UNIQUE(`email`)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO member
  (first_name, last_name, email, gender)
VALUES
  ('Changkuan', 'Li', 'changkuanli@gmail.com', 'male'),
  ('Benjamin', 'Leddige', 'benjaminleddige@gmail.com', 'male');

DROP TABLE IF EXISTS `instructor`;
CREATE TABLE `instructor`(
  `instructor_ID` INT(11) NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(255) NOT NULL,
  `last_name` VARCHAR(255) NOT NULL,
  PRIMARY KEY(`instructor_ID`)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO instructor
  (first_name, last_name)
VALUES
  ('Noah', 'A'),
  ('Michael', 'B'),
  ('Josh', 'C');

DROP TABLE IF EXISTS `class`;
CREATE TABLE `class`(
  `class_ID` INT(11) NOT NULL AUTO_INCREMENT,
  `instructor_ID` INT(11),
  `class_name` VARCHAR(255) NOT NULL,
  `class_date` DATE NOT NULL,
  `class_time` TIME NOT NULL,
  `room` INT(11) NOT NULL,
  PRIMARY KEY(`class_ID`),
  FOREIGN KEY(`instructor_ID`) REFERENCES instructor(`instructor_ID`) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO class
  (instructor_ID, class_name, class_date, class_time, room)
VALUES
  ((SELECT instructor_ID FROM instructor WHERE first_name='Noah' AND last_name='A'), 'Yoga', '2019-10-26', '12:00:00', '1'),
  ((SELECT instructor_ID FROM instructor WHERE first_name='Michael' AND last_name='B'), 'Zumba', '2019-10-26', '13:00:00', '2'),
  ((SELECT instructor_ID FROM instructor WHERE first_name='Josh' AND last_name='C'), 'Weight-lifting', '2019-10-26', '14:00:00', '3'),
  ((SELECT instructor_ID FROM instructor WHERE first_name='Noah' AND last_name='A'), 'Cycling', '2019-10-26', '15:00:00', '4');

DROP TABLE IF EXISTS `member_class`;
CREATE TABLE `member_class`(
  `member_class_ID` INT(11) NOT NULL AUTO_INCREMENT,
  `member_ID` INT(11),
  `class_ID` INT(11),
  PRIMARY KEY(`member_class_ID`),
  FOREIGN KEY(`member_ID`) REFERENCES member(`member_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY(`class_ID`) REFERENCES class(`class_ID`) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO member_class
  (member_ID, class_ID)
VALUES
  ((SELECT member_ID FROM member WHERE email='changkuanli@gmail.com'), (SELECT class_ID from class WHERE class_name='Yoga' AND class_date='2019-10-26' AND class_time='12:00:00')),
  ((SELECT member_ID FROM member WHERE email='benjaminleddige@gmail.com'), (SELECT class_ID from class WHERE class_name='Zumba' AND class_date='2019-10-26' AND class_time='13:00:00'));

DROP TABLE IF EXISTS `cert`;
CREATE TABLE `cert`(
  `cert_ID` INT(11) NOT NULL AUTO_INCREMENT,
  `class_name` VARCHAR(255) NOT NULL,
  PRIMARY KEY(`cert_ID`)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO cert
  (class_name)
VALUES
  ('Yoga'),
  ('Zumba'),
  ('Weight-lifting'),
  ('Cycling');

DROP TABLE IF EXISTS `instructor_cert`;
CREATE TABLE `instructor_cert`(
  `instructor_cert_ID` INT(11) NOT NULL AUTO_INCREMENT,
  `instructor_ID` INT(11),
  `cert_ID` INT(11),
  PRIMARY KEY(`instructor_cert_ID`),
  FOREIGN KEY(`instructor_ID`) REFERENCES instructor(`instructor_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY(`cert_ID`) REFERENCES cert(`cert_ID`) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO instructor_cert
  (instructor_ID, cert_ID)
VALUES
  ((SELECT instructor_ID FROM instructor WHERE first_name='Noah' AND last_name='A'), (SELECT cert_ID FROM cert WHERE class_name='Yoga')),
  ((SELECT instructor_ID FROM instructor WHERE first_name='Michael' AND last_name='B'), (SELECT cert_ID FROM cert WHERE class_name='Zumba')),
  ((SELECT instructor_ID FROM instructor WHERE first_name='Josh' AND last_name='C'), (SELECT cert_ID FROM cert WHERE class_name='Weight-lifting')),
  ((SELECT instructor_ID FROM instructor WHERE first_name='Noah' AND last_name='A'), (SELECT cert_ID FROM cert WHERE class_name='Cycling'));
