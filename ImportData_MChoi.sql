--**********************************************************************************************--
-- Title: Final Assignment: Milstone 03
-- Author: MinseokChoi
-- Desc: This file designs and imports sample data
-- for patients appointments application. 
-- Change Log: When,Who,What
-- 2021-03-07,MinseokChoi,Created File
--***********************************************************************************************--
USE FinalDB_MinseokChoi;
GO

-- Resetting each table's data
DELETE FROM Appointments;
DBCC CHECKIDENT (Appointments, RESEED, 0);
DELETE FROM Clinics;
DBCC CHECKIDENT (Clinics, RESEED, 0);
DELETE FROM Doctors;
DBCC CHECKIDENT (Doctors, RESEED, 0);
DELETE FROM Patients;
DBCC CHECKIDENT (Patients, RESEED, 0);


EXEC sp_help Clinics;
EXEC sp_help Doctors;
EXEC sp_help Patients;
EXEC sp_help Appointments;

-- Importing 7 sample data for Clinics
INSERT INTO Clinics
    (ClinicName, ClinicPhoneNumber, ClinicAddress, ClinicCity, ClinicState, ClinicZipCode)
VALUES
    ('Eagle owl (unidentified)', '319-601-6025', '001 Debs Road', 'Cedar Rapids', 'IA', '52410');
INSERT INTO Clinics
    (ClinicName, ClinicPhoneNumber, ClinicAddress, ClinicCity, ClinicState, ClinicZipCode)
VALUES
    ('Southern tamandua', '313-981-4474', '39 Del Mar Lane', 'Detroit', 'MI', '48224');
INSERT INTO Clinics
    (ClinicName, ClinicPhoneNumber, ClinicAddress, ClinicCity, ClinicState, ClinicZipCode)
VALUES
    ('Black-eyed bulbul', '864-418-4084', '9 Ludington Hill', 'Spartanburg', 'SC', '29305');
INSERT INTO Clinics
    (ClinicName, ClinicPhoneNumber, ClinicAddress, ClinicCity, ClinicState, ClinicZipCode)
VALUES
    ('Booby, blue-faced', '607-821-4600', '83 Shopko Street', 'Elmira', 'NY', '14905');
INSERT INTO Clinics
    (ClinicName, ClinicPhoneNumber, ClinicAddress, ClinicCity, ClinicState, ClinicZipCode)
VALUES
    ('Galapagos hawk', '586-820-1342', '63802 Old Gate Alley', 'Warren', 'MI', '48092');
INSERT INTO Clinics
    (ClinicName, ClinicPhoneNumber, ClinicAddress, ClinicCity, ClinicState, ClinicZipCode)
VALUES
    ('Southern black-backed gull', '215-202-4994', '0 Dovetail Parkway', 'Philadelphia', 'PA', '19151');
INSERT INTO Clinics
    (ClinicName, ClinicPhoneNumber, ClinicAddress, ClinicCity, ClinicState, ClinicZipCode)
VALUES
    ('Stick insect', '404-402-5982', '20 Heath Plaza', 'Atlanta', 'GA', '30351');

SELECT *
FROM vClinics;

-- Importing 12 sample data for Doctors
INSERT INTO Doctors
    (DoctorFirstName, DoctorLastName, DoctorPhoneNumber, DoctorAddress, DoctorCity, DoctorState, DoctorZipCode)
VALUES
    ('Tim', 'Salomon', '309-483-7647', '2740 Norway Maple Hill', 'Peoria', 'IL', '61656');
INSERT INTO Doctors
    (DoctorFirstName, DoctorLastName, DoctorPhoneNumber, DoctorAddress, DoctorCity, DoctorState, DoctorZipCode)
VALUES
    ('Zena', 'Kirman', '309-900-9347', '95 Evergreen Road', 'Peoria', 'IL', '61656');
INSERT INTO Doctors
    (DoctorFirstName, DoctorLastName, DoctorPhoneNumber, DoctorAddress, DoctorCity, DoctorState, DoctorZipCode)
VALUES
    ('Maxwell', 'Piggins', '816-388-6885', '48 John Wall Center', 'Kansas City', 'MO', '64142');
INSERT INTO Doctors
    (DoctorFirstName, DoctorLastName, DoctorPhoneNumber, DoctorAddress, DoctorCity, DoctorState, DoctorZipCode)
VALUES
    ('Ephrayim', 'Garric', '813-787-5757', '4794 Judy Pass', 'Tampa', 'FL', '33615');
INSERT INTO Doctors
    (DoctorFirstName, DoctorLastName, DoctorPhoneNumber, DoctorAddress, DoctorCity, DoctorState, DoctorZipCode)
VALUES
    ('Horst', 'Robbs', '770-840-0695', '43 Hansons Drive', 'Duluth', 'GA', '30195');
INSERT INTO Doctors
    (DoctorFirstName, DoctorLastName, DoctorPhoneNumber, DoctorAddress, DoctorCity, DoctorState, DoctorZipCode)
VALUES
    ('Louella', 'Whitcombe', '562-741-1044', '58899 Scoville Point', 'Long Beach', 'CA', '90847');
INSERT INTO Doctors
    (DoctorFirstName, DoctorLastName, DoctorPhoneNumber, DoctorAddress, DoctorCity, DoctorState, DoctorZipCode)
VALUES
    ('Isidora', 'McHarry', '805-627-2850', '55 Texas Parkway', 'San Luis Obispo', 'CA', '93407');
INSERT INTO Doctors
    (DoctorFirstName, DoctorLastName, DoctorPhoneNumber, DoctorAddress, DoctorCity, DoctorState, DoctorZipCode)
VALUES
    ('Kalie', 'Iskov', '920-430-6783', '124 Doe Crossing Point', 'Green Bay', 'WI', '54313');
INSERT INTO Doctors
    (DoctorFirstName, DoctorLastName, DoctorPhoneNumber, DoctorAddress, DoctorCity, DoctorState, DoctorZipCode)
VALUES
    ('Paxon', 'Kull', '209-528-0561', '58 Esch Circle', 'Fresno', 'CA', '93704');
INSERT INTO Doctors
    (DoctorFirstName, DoctorLastName, DoctorPhoneNumber, DoctorAddress, DoctorCity, DoctorState, DoctorZipCode)
VALUES
    ('Sonni', 'Kayzer', '214-409-0974', '6 Dixon Place', 'Dallas', 'TX', '75372');
INSERT INTO Doctors
    (DoctorFirstName, DoctorLastName, DoctorPhoneNumber, DoctorAddress, DoctorCity, DoctorState, DoctorZipCode)
VALUES
    ('Alec', 'Kenyam', '585-960-6215', '00 Bellgrove Street', 'Rochester', 'NY', '14652');
INSERT INTO Doctors
    (DoctorFirstName, DoctorLastName, DoctorPhoneNumber, DoctorAddress, DoctorCity, DoctorState, DoctorZipCode)
VALUES
    ('Salomon', 'Bundock', '412-326-2359', '54 Pankratz Avenue', 'Pittsburgh', 'PA', '15220');

SELECT *
FROM vDoctors;

-- Inserting 12 sample data for Patients 
INSERT INTO Patients
    (PatientFirstName, PatientLastName, PatientPhoneNumber, PatientAddress, PatientCity, PatientState, PatientZipCode)
VALUES
    ('Ramon', 'Hazard', '810-470-8884', '5 Sommers Court', 'Southfield', 'MI', '48076');
INSERT INTO Patients
    (PatientFirstName, PatientLastName, PatientPhoneNumber, PatientAddress, PatientCity, PatientState, PatientZipCode)
VALUES
    ('Ethel', 'Rehm', '915-212-3589', '772 Russell Parkway', 'El Paso', 'TX', '88569');
INSERT INTO Patients
    (PatientFirstName, PatientLastName, PatientPhoneNumber, PatientAddress, PatientCity, PatientState, PatientZipCode)
VALUES
    ('Andre', 'Paulin', '937-940-5562', '0745 Petterle Road', 'Hamilton', 'OH', '45020');
INSERT INTO Patients
    (PatientFirstName, PatientLastName, PatientPhoneNumber, PatientAddress, PatientCity, PatientState, PatientZipCode)
VALUES
    ('Freedman', 'Cant', '760-732-8676', '0 Roxbury Way', 'San Bernardino', 'CA', '92415');
INSERT INTO Patients
    (PatientFirstName, PatientLastName, PatientPhoneNumber, PatientAddress, PatientCity, PatientState, PatientZipCode)
VALUES
    ('Kylen', 'Ivel', '808-695-4699', '8771 Maryland Way', 'Honolulu', 'HI', '96835');
INSERT INTO Patients
    (PatientFirstName, PatientLastName, PatientPhoneNumber, PatientAddress, PatientCity, PatientState, PatientZipCode)
VALUES
    ('Vanda', 'McCullagh', '559-814-1795', '592 Golf Trail', 'Fresno', 'CA', '93750');
INSERT INTO Patients
    (PatientFirstName, PatientLastName, PatientPhoneNumber, PatientAddress, PatientCity, PatientState, PatientZipCode)
VALUES
    ('Roxana', 'Charlwood', '423-400-7548', '037 David Street', 'Chattanooga', 'TN', '37450');
INSERT INTO Patients
    (PatientFirstName, PatientLastName, PatientPhoneNumber, PatientAddress, PatientCity, PatientState, PatientZipCode)
VALUES
    ('Rad', 'Troughton', '816-604-5075', '02912 Russell Park', 'Saint Joseph', 'MO', '64504');
INSERT INTO Patients
    (PatientFirstName, PatientLastName, PatientPhoneNumber, PatientAddress, PatientCity, PatientState, PatientZipCode)
VALUES
    ('Brooke', 'Fay', '603-549-7729', '2 Stone Corner Pass', 'Portsmouth', 'NH', '03804');
INSERT INTO Patients
    (PatientFirstName, PatientLastName, PatientPhoneNumber, PatientAddress, PatientCity, PatientState, PatientZipCode)
VALUES
    ('Clayborne', 'Squire', '209-151-5620', '67972 5th Plaza', 'Modesto', 'CA', '95354');
INSERT INTO Patients
    (PatientFirstName, PatientLastName, PatientPhoneNumber, PatientAddress, PatientCity, PatientState, PatientZipCode)
VALUES
    ('Gwen', 'Pybus', '407-499-6035', '731 Hintze Terrace', 'Orlando', 'FL', '32854');
INSERT INTO Patients
    (PatientFirstName, PatientLastName, PatientPhoneNumber, PatientAddress, PatientCity, PatientState, PatientZipCode)
VALUES
    ('Tamra', 'Crooke', '510-895-9448', '06383 Summer Ridge Point', 'Berkeley', 'CA', '94705');

SELECT *
FROM vPatients;

-- Inserting 100 sample data for Appointments  
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('8/14/2012', 2, 9, 7);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('9/27/2015', 12, 8, 2);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('10/9/2012', 9, 10, 5);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('12/23/2016', 11, 3, 5);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('9/5/2018', 7, 5, 3);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('5/12/2018', 10, 7, 6);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('10/31/2012', 2, 5, 3);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('10/5/2015', 4, 6, 5);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('6/21/2016', 2, 8, 6);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('12/29/2018', 8, 12, 3);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('11/25/2018', 8, 8, 4);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('3/7/2017', 9, 11, 3);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('2/12/2019', 7, 10, 4);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('3/6/2011', 4, 2, 3);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('9/14/2020', 7, 1, 5);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('12/2/2017', 5, 5, 5);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('7/30/2010', 4, 4, 1);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('6/2/2016', 5, 7, 4);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('4/14/2015', 11, 1, 5);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('11/6/2011', 1, 11, 7);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('11/23/2016', 7, 9, 5);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('7/26/2013', 10, 8, 1);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('9/1/2012', 12, 3, 7);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('12/4/2010', 8, 12, 5);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('8/6/2017', 3, 12, 1);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('8/16/2010', 9, 3, 5);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('10/27/2017', 10, 12, 7);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('2/17/2012', 7, 1, 5);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('5/25/2015', 4, 6, 3);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('10/11/2017', 2, 8, 3);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('2/8/2016', 11, 12, 4);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('8/10/2020', 1, 6, 4);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('12/18/2020', 1, 1, 2);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('5/9/2015', 7, 8, 6);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('1/4/2021', 6, 11, 7);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('2/2/2012', 3, 11, 7);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('10/30/2013', 6, 4, 4);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('1/18/2016', 10, 5, 2);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('5/22/2019', 9, 8, 3);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('4/15/2018', 10, 1, 5);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('1/17/2015', 9, 9, 5);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('5/29/2020', 5, 6, 2);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('12/29/2013', 10, 8, 7);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('7/14/2020', 7, 5, 3);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('1/14/2020', 5, 6, 7);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('3/12/2019', 7, 5, 1);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('12/5/2017', 10, 11, 5);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('6/7/2011', 2, 9, 5);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('10/28/2016', 3, 5, 6);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('10/8/2019', 4, 8, 5);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('8/7/2019', 11, 5, 4);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('2/8/2016', 8, 6, 5);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('5/19/2011', 9, 2, 7);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('3/15/2012', 3, 12, 1);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('9/14/2020', 9, 10, 1);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('1/12/2017', 4, 5, 6);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('12/14/2019', 11, 5, 3);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('1/12/2016', 1, 1, 1);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('2/3/2014', 12, 1, 1);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('1/13/2011', 2, 3, 6);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('8/3/2015', 11, 10, 6);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('10/24/2014', 9, 7, 5);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('2/18/2015', 10, 5, 1);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('4/17/2018', 12, 7, 4);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('12/2/2010', 9, 1, 4);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('9/16/2017', 4, 8, 1);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('1/25/2021', 3, 8, 5);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('5/29/2018', 7, 8, 3);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('9/18/2012', 5, 10, 4);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('5/6/2013', 1, 1, 4);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('12/5/2012', 7, 8, 7);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('12/10/2017', 10, 7, 2);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('9/11/2014', 7, 9, 7);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('4/18/2012', 1, 10, 1);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('7/10/2015', 5, 5, 2);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('7/1/2015', 1, 8, 5);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('6/7/2019', 10, 6, 4);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('11/30/2016', 1, 2, 6);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('6/27/2014', 10, 4, 4);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('11/11/2015', 9, 7, 4);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('6/25/2011', 12, 11, 2);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('11/17/2014', 4, 11, 4);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('2/11/2019', 11, 10, 5);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('1/28/2017', 8, 6, 7);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('1/18/2019', 12, 4, 2);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('6/30/2018', 5, 8, 5);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('3/1/2011', 2, 3, 4);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('5/2/2014', 11, 5, 6);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('3/10/2020', 2, 10, 1);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('8/23/2011', 3, 4, 1);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('6/13/2020', 11, 4, 4);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('6/27/2013', 12, 10, 4);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('9/25/2020', 3, 4, 5);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('12/20/2011', 11, 5, 3);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('11/15/2013', 4, 11, 1);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('7/27/2015', 4, 3, 2);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('4/2/2016', 5, 12, 3);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('8/18/2018', 4, 9, 3);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('12/23/2020', 4, 11, 5);
INSERT INTO Appointments
    (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
VALUES
    ('9/16/2010', 5, 8, 3);

SELECT *
FROM vAppointments;


