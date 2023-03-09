CREATE TABLE patient ( 
 patient_id INT NOT NULL, 
 first_name VARCHAR2(45) NOT NULL, 
 last_name VARCHAR2(45) NOT NULL, 
 patient_blood_type VARCHAR2(45) NOT NULL, 
 patient_condition VARCHAR2(45) NOT NULL, 
 city VARCHAR2(45) NOT NULL, 
 street VARCHAR2(45) NOT NULL, 
 file_number INT NOT NULL , 
 PRIMARY KEY (patient_id) );
CREATE TABLE hospital ( 
 file_number INT NOT NULL, 
 blood_bank_name VARCHAR2(45) NOT NULL, 
 donor_name VARCHAR2(45) NOT NULL, 
 donor_age INT NOT NULL, 
 donor_weight INT NULL, 
 donor_phone_number VARCHAR2(45) NULL, 
 donor_gender VARCHAR2(45) NULL, 
 blood_type VARCHAR2(45) NULL , 
 PRIMARY KEY (file_number));
CREATE TABLE blood_bank ( 
 blood_bank_name VARCHAR2(45) NOT NULL, 
 city VARCHAR2(45) NOT NULL, 
 street VARCHAR2(45) NOT NULL, 
 donor_name VARCHAR2(45) NOT NULL, 
 blood_bank_contact_number VARCHAR2(10) NULL, 
 donation_type VARCHAR2(45) NULL, 
 PRIMARY KEY (blood_bank_name));
CREATE TABLE donor ( 
 donor_id INT NOT NULL, 
 first_name VARCHAR2(45) NOT NULL, 
 last_name VARCHAR2(45) NOT NULL, 
 donor_blood_type VARCHAR2(45) NOT NULL, 
 city VARCHAR2(45) NULL, 
 street VARCHAR2(45) NULL, 
 donor_bank_contact_number VARCHAR2(10) NOT NULL, 
 blood_part VARCHAR2(45) NOT NULL, 
 PRIMARY KEY (donor_id));
CREATE table blood_hospital_information( 
 file_number INT NOT NULL, 
 blood_bank_name VARCHAR2(45) NOT NULL, 
 Date_provided Date not null, 
 PRIMARY KEY(file_number,blood_bank_name) 
);
CREATE table donor_blood_information( 
 blood_bank_name VARCHAR2(45) NOT NULL, 
 donor_id INT NOT NULL, 
 provided_date Date not null, 
 PRIMARY KEY(blood_bank_name,donor_id) 
);
insert into patient VALUES 
(2113140,'yara','alshehri','O','yes','jeddah','almanar',2113100)insert into patient VALUES 
(2110240,'rimas','alshehri','O','no','jeddah','alnuzha',2110211)
insert into patient VALUES 
(2110250,'taif','alharbi','A','yes','abha','alsalamah',2110222)
insert into patient VALUES 
(2110233,'asmaa','mahdi','AB','no','makkah','alharameen',2110233)
insert into patient VALUES 
(2110278,'sara','alotaibi','B','yes','jeddah','alnaseem',2110244)
insert into hospital VALUES(2113100,'Give blood give life','faisal',19, 70,'0538493898','male','A')
insert into hospital VALUES(2110211,'Center blood bank', 'fatima', 23, 60,'0567263546', 'female', 'O')
insert into hospital VALUES(2110222,'Wateen bolld bank','nourah',45,66,'0598787687','female','AB')
insert into hospital VALUES(2110233,'Dallah blood bank', 'ahmad',30,89,'0512312321','male','O')
insert into hospital VALUES(2110244,'friends blood bank','khalid',36,76,'0524135261','male','A')
insert into blood_bank VALUES('Give blood give life','jeddah','alsalamah','faisal','0538493898','full')
insert into blood_bank VALUES('Center blood bank','jeddah','alfaisalyah','fatima','0567263546','full')
insert into blood_bank VALUES('Wateen bolld bank','abha','alharameen','nourah','0598787687','partial')
insert into blood_bank VALUES('Dallah blood bank','makkah','alajwad','ahmad','0512312321','partial')
insert into blood_bank VALUES('friends blood bank','jeddah','alnaseem','khalid','0524135261','full')
insert into donor VALUES(0013140,'faisal','alshehri','A','jeddah','alsalamah','0538493898','blood')
insert into donor VALUES(1110240,'fatima','alghamdi','O','jeddah','alfaisalyah','0567263546','platelets')
insert into donor VALUES(2210250,'nourah','alshahrani','AB','abha','alharameen','0598787687','blood')
insert into donor VALUES(3310233,'ahmad','alasmari','O','makkah','alajwad','0512312321','platelets')
insert into donor VALUES(4410278,'khalid','alamri','A','jeddah','alnaseem','0524135261','blood')
ALTER TABLE patient ADD CONSTRAINT file_no_fk FOREIGN KEY(file_number) REFERENCEs 
hospital(file_number)
SELECT patient_id, COUNT(patient_id) AS number_of_patients FROM patient GROUP BY patient_id;
SELECT file_number, blood_bank_name,donor_name,donor_age 
,donor_weight,donor_phone_number,donor_gender,blood_type;
SELECT hospital.file_number, hospital.donor_name, patient.first_name, patient.patient_blood_type 
FROM hospital JOIN patient ON hospital.file_number=patient.file_number;
SELECT patient_id,first_name,last_name FROM patient 
WHERE last_name IN(SELECT last_name FROM patient WHERE last_name='alshehri');CREATE OR 
REPLACE PROCEDURE info_donor(info_id IN DONOR.DONOR_ID%TYPE) 
AS 
 info_fn DONOR.FIRST_NAME%TYPE; 
 info_ln DONOR.LAST_NAME%TYPE; 
 info_donorBT DONOR.DONOR_BLOOD_TYPE%TYPE; 
 info_city DONOR.CITY%TYPE; 
 info_street DONOR.STREET%TYPE; 
 info_donorCN DONOR.DONOR_BANK_CONTACT_NUMBER%TYPE; 
 info_bloodP DONOR.BLOOD_PART%TYPE; 
BEGIN 
 SELECT FIRST_NAME, LAST_NAME, DONOR_BLOOD_TYPE, CITY, STREET, 
DONOR_BANK_CONTACT_NUMBER, BLOOD_PART 
 INTO info_fn, info_ln, info_donorBT, info_city, info_street, info_donorCN, info_bloodP 
 FROM DONOR WHERE DONOR_ID = info_id; 
 DBMS_OUTPUT.PUT_LINE('1 # : '|| info_id); 
 DBMS_OUTPUT.PUT_LINE('2 # : '|| info_fn); 
 DBMS_OUTPUT.PUT_LINE('3 # : '|| info_ln); 
 DBMS_OUTPUT.PUT_LINE('4 # : '|| info_donorBT); 
 DBMS_OUTPUT.PUT_LINE('5 # : '|| info_city); 
 DBMS_OUTPUT.PUT_LINE('6 # : '|| info_street); 
 DBMS_OUTPUT.PUT_LINE('7 # : '|| info_donorCN); 
 DBMS_OUTPUT.PUT_LINE('8 # : '|| info_bloodP); 
END;
EXEC info_donor(0013140)
CREATE OR REPLACE PROCEDURE UpdateBP(DONOR_ID IN NUMBER, NewBP VARCHAR2) 
 AS 
BEGIN 
UPDATE DONOR SET BLOOD_PART = NewBP WHERE DONOR_ID = DONOR_ID; 
COMMIT; END;
call UpdateBP(2210250, 'platelets')