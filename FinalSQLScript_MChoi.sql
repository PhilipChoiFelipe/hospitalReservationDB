--**********************************************************************************************--
-- Title: Hospital Reservation System
-- Author: MinseokChoi
-- Desc: This file designs and creates tables, constraints, views, stored procedures, and permissions
-- for patients appointments application. 
-- Change Log: When,Who,What
-- 2021-02-29,MinseokChoi,Created File
--***********************************************************************************************--
Begin Try
	Use Master;
	If Exists(Select Name
From SysDatabases
Where Name = 'FinalDB_MinseokChoi')
	 Begin
    Alter Database [FinalDB_MinseokChoi] set Single_user With Rollback Immediate;
    Drop Database FinalDB_MinseokChoi;
End
	Create Database FinalDB_MinseokChoi;
End Try
Begin Catch
	Print Error_Number();
End Catch
go
Use FinalDB_MinseokChoi;

GO

-- Create Tables, Views, Procedures
--*******************************************************************************************************************
-- Clinics
--*******************************************************************************************************************
-- Clinics/Tables
CREATE TABLE dbo.Clinics
(
    ClinicID INT CONSTRAINT pkClinic PRIMARY KEY NOT NULL IDENTITY(1,1),
    ClinicName NVARCHAR(100) CONSTRAINT uqClinicName UNIQUE NOT NULL,
    ClinicPhoneNumber NVARCHAR(100) CONSTRAINT ckClinicPhoneNumber CHECK (ClinicPhoneNumber LIKE '[0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]') NOT NULL,
    ClinicAddress NVARCHAR(100) NOT NULL,
    ClinicCity NVARCHAR(100) NOT NULL,
    ClinicState NVARCHAR(2) NOT NULL,
    ClinicZipCode NVARCHAR(10) CONSTRAINT ckClinicZipCode CHECK (ClinicZipCode LIKE '[0-9][0-9][0-9][0-9][0-9]' OR
            ClinicZipCode LIKE '[0-9][0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]') NOT NULL
)
GO

-- Clinics/Views
GO
CREATE VIEW [dbo].[vClinics]
/* Author: Minseok Choi
** Desc: Show all data from Clinics table
** Change Log: When,Who,What
** 2021-02-29,Minseok choi,Created View.
*/
WITH
    SCHEMABINDING
AS
    SELECT
        [ClinicID],
        [ClinicName],
        [ClinicPhoneNumber],
        [ClinicAddress],
        [ClinicCity],
        [ClinicState],
        [ClinicZipCode]
    FROM [dbo].[Clinics] AS C
GO

---- Clinics/Procedures/Insert
CREATE PROCEDURE pInsClinics
    (@ClinicID INT OUTPUT,
    @ClinicName NVARCHAR(100),
    @ClinicPhoneNumber NVARCHAR(100),
    @ClinicAddress NVARCHAR(100),
    @ClinicCity NVARCHAR(100),
    @ClinicState NVARCHAR(2),
    @ClinicZipCode NVARCHAR(10))
/* Author: Minseok Choi
** Desc: Processes inserting new Clinic into Clinics table and captures newly created Clinic.
** Change Log: When,Who,What
** 2021-02-29,Minseok choi,Created stored procedure.
*/
AS
BEGIN
    DECLARE @RC int = 0;
    BEGIN TRY
   BEGIN TRANSACTION 
    INSERT INTO Clinics
        (ClinicName, ClinicPhoneNumber, ClinicAddress, ClinicCity, ClinicState, ClinicZipCode)
    VALUES(@ClinicName, @ClinicPhoneNumber, @ClinicAddress, @ClinicCity, @ClinicState, @ClinicZipCode)
    SELECT @ClinicID = SCOPE_IDENTITY();
   COMMIT TRANSACTION
   SET @RC = +1
  END TRY
  BEGIN CATCH
   IF(@@Trancount > 0) ROLLBACK TRANSACTION
   PRINT Error_Message();
   SET @RC = -1
  END CATCH
    RETURN @RC;
END
GO

-- Clinics/Procedures/Insert/Test
DECLARE @InsertedClinicID INT;
DECLARE @Status INT;
EXEC @Status = pInsClinics 
@ClinicID = @InsertedClinicID OUTPUT,
@ClinicName = 'MINSEOK CLINIC 2',
@ClinicPhoneNumber ='010-234-2341',
@ClinicAddress='1231231',
@ClinicCity='seattle',
@ClinicState='WA',
@ClinicZipCode='12345-7890'
SELECT CASE @Status
    WHEN +1 THEN 'Insert was successful!'
    WHEN -1 THEN 'Insert Failed! Common Issues: Duplicate Data'
    END AS [Status]
SELECT [Inserted Attempt Clinics ID Was:] = @InsertedClinicID
SELECT *
FROM vClinics;
GO

---- Clinics/Procedures/Update
CREATE PROCEDURE pUpdClinics
    (@ClinicID INT,
    @ClinicName NVARCHAR(100),
    @ClinicPhoneNumber NVARCHAR(100),
    @ClinicAddress NVARCHAR(100),
    @ClinicCity NVARCHAR(100),
    @ClinicState NVARCHAR(2),
    @ClinicZipCode NVARCHAR(10))
/* Author: Minseok Choi
** Desc: Processes updating new Clinic into Clinics table
** Change Log: When,Who,What
** 2021-02-29,Minseok choi,Created stored procedure.
*/
AS
BEGIN
    DECLARE @RC int = 0;
    BEGIN TRY
   BEGIN TRANSACTION 
    UPDATE Clinics SET ClinicName = @ClinicName, ClinicPhoneNumber = @ClinicPhoneNumber, ClinicAddress = @ClinicAddress, ClinicCity = @ClinicCity, ClinicState = @ClinicState, ClinicZipCode = @ClinicZipCode
	WHERE ClinicID = @ClinicID
   COMMIT TRANSACTION
   SET @RC = +1
  END TRY
  BEGIN CATCH
   IF(@@Trancount > 0) ROLLBACK TRANSACTION
   PRINT Error_Message();
   SET @RC = -1
  END CATCH
    RETURN @RC;
END
GO

-- Clinics/Procedures/Update/Test
DECLARE @Status INT;
DECLARE @ClinicsLastID INT = IDENT_CURRENT('Clinics')
EXEC @Status = pUpdClinics 
@ClinicID = @ClinicsLastID,
@ClinicName = 'OTHER CLINICS 2',
@ClinicPhoneNumber ='010-234-1234',
@ClinicAddress='Hello World',
@ClinicCity='seattle',
@ClinicState='WA',
@ClinicZipCode='12345-7890'
SELECT CASE @Status
    WHEN +1 THEN 'Update was successful!'
    WHEN -1 THEN 'Update Failed! Common Issues: Duplicate Data'
    END AS [Status]
SELECT [Updated Attempt Clinics ID Was:] = @@IDENTITY
SELECT *
FROM vClinics;
GO

---- Clinics/Procedures/Delete
CREATE PROCEDURE pDelClinics
    (@ClinicID INT)
/* Author: Minseok Choi
** Desc: Processes deleting new Clinic into Clinics table
** Change Log: When,Who,What
** 2021-02-29,Minseok choi,Created stored procedure.
*/
AS
BEGIN
    DECLARE @RC int = 0;
    BEGIN TRY
   BEGIN TRANSACTION 
    DELETE Clinics 
	WHERE ClinicID = @ClinicID
   COMMIT TRANSACTION
   SET @RC = +1
  END TRY
  BEGIN CATCH
   IF(@@Trancount > 0) ROLLBACK TRANSACTION
   PRINT Error_Message();
   SET @RC = -1
  END CATCH
    RETURN @RC;
END
GO

-- Clinics/Procedures/Delete/Test
DECLARE @Status INT;
DECLARE @ClinicsLastID INT = IDENT_CURRENT('Clinics')
EXEC @Status = pDelClinics 
@ClinicID = @ClinicsLastID
SELECT CASE @Status
    WHEN +1 THEN 'Delete was successful!'
    WHEN -1 THEN 'Delete Failed! Common Issues: Duplicate Data'
    END AS [Status]
SELECT [Deleted Attempt Clinics ID Was:] = @@IDENTITY
SELECT *
FROM vClinics;
GO

--*******************************************************************************************************************
-- Patients
--*******************************************************************************************************************
-- Patients/Tables
CREATE TABLE dbo.Patients
(
    PatientID INT CONSTRAINT pkPatient PRIMARY KEY NOT NULL IDENTITY(1,1),
    PatientFirstName NVARCHAR(100) NOT NULL,
    PatientLastName NVARCHAR(100) NOT NULL,
    PatientPhoneNumber NVARCHAR(100) CONSTRAINT ckPatientPhoneNumber CHECK (PatientPhoneNumber LIKE '[0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]') NOT NULL,
    PatientAddress NVARCHAR(100) NOT NULL,
    PatientCity NVARCHAR(100) NOT NULL,
    PatientState NVARCHAR(2) NOT NULL,
    PatientZipCode NVARCHAR(10) CONSTRAINT ckPatientZipCode CHECK (PatientZipCode LIKE '[0-9][0-9][0-9][0-9][0-9]' OR
            PatientZipCode LIKE '[0-9][0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]') NOT NULL
)

-- Patients/Views
GO
CREATE VIEW [dbo].[vPatients]
/* Author: Minseok Choi
** Desc: Show all data from Patients table
** Change Log: When,Who,What
** 2021-02-29,Minseok choi,Created View.
*/
AS
    SELECT
        [PatientID],
        [PatientFirstName],
        [PatientLastName],
        [PatientPhoneNumber],
        [PatientAddress],
        [PatientCity],
        [PatientState],
        [PatientZipCode]
    FROM [dbo].[Patients]
GO

---- Patients/Procedures/Insert
CREATE PROCEDURE pInsPatients
    (@PatientID INT OUTPUT,
    @PatientFirstName NVARCHAR(100),
    @PatientLastName NVARCHAR(100) ,
    @PatientPhoneNumber NVARCHAR(100) ,
    @PatientAddress NVARCHAR(100) ,
    @PatientCity NVARCHAR(100) ,
    @PatientState NVARCHAR(2) ,
    @PatientZipCode NVARCHAR(10))
/* Author: Minseok Choi
** Desc: Processes inserting new Patient into Patients table and captures newly created Patient.
** Change Log: When,Who,What
** 2021-02-29,Minseok choi,Created stored procedure.
*/
AS
BEGIN
    DECLARE @RC int = 0;
    BEGIN TRY
   BEGIN TRANSACTION 
    INSERT INTO Patients
        (PatientFirstName, PatientLastName, PatientPhoneNumber, PatientAddress, PatientCity, PatientState, PatientZipCode)
    VALUES(@PatientFirstName, @PatientLastName, @PatientPhoneNumber, @PatientAddress, @PatientCity, @PatientState, @PatientZipCode)
    SELECT @PatientID = SCOPE_IDENTITY();
   COMMIT TRANSACTION
   SET @RC = +1
  END TRY
  BEGIN CATCH
   IF(@@Trancount > 0) ROLLBACK TRANSACTION
   PRINT Error_Message();
   SET @RC = -1
  END CATCH
    RETURN @RC;
END
GO

-- Patients/Procedures/Insert/Test
DECLARE @InsertedPatientID INT;
DECLARE @Status INT;
EXEC @Status = pInsPatients 
@PatientID = @InsertedPatientID OUTPUT,
@PatientFirstName = 'FELIPE',
@PatientLastName = 'CHOI',
@PatientPhoneNumber = '010-234-1231',
@PatientAddress = 'Hello Earth',
@PatientCity = 'Seattle',
@PatientState = 'WA',
@PatientZipCode = '12345-7890'
SELECT CASE @Status
    WHEN +1 THEN 'Insert was successful!'
    WHEN -1 THEN 'Insert Failed! Common Issues: Duplicate Data'
    END AS [Status]
SELECT [Inserted Attempt Patient ID Was:] = @InsertedPatientID
SELECT *
FROM vPatients;
GO


---- Patients/Procedures/Update
CREATE PROCEDURE pUpdPatients
    (@PatientID INT,
    @PatientFirstName NVARCHAR(100),
    @PatientLastName NVARCHAR(100) ,
    @PatientPhoneNumber NVARCHAR(100) ,
    @PatientAddress NVARCHAR(100) ,
    @PatientCity NVARCHAR(100) ,
    @PatientState NVARCHAR(2) ,
    @PatientZipCode NVARCHAR(10))
/* Author: Minseok Choi
** Desc: Processes updating new Patient into Patients table
** Change Log: When,Who,What
** 2021-02-29,Minseok choi,Created stored procedure.
*/
AS
BEGIN
    DECLARE @RC int = 0;
    BEGIN TRY
   BEGIN TRANSACTION 
    UPDATE Patients SET PatientFirstName = @PatientFirstName, PatientLastName = @PatientLastName, PatientPhoneNumber = @PatientPhoneNumber, PatientAddress = @PatientAddress, PatientCity = @PatientCity, PatientState = @PatientState, PatientZipCode = @PatientZipCode
	WHERE PatientID = @PatientID
   COMMIT TRANSACTION
   SET @RC = +1
  END TRY
  BEGIN CATCH
   IF(@@Trancount > 0) ROLLBACK TRANSACTION
   PRINT Error_Message();
   SET @RC = -1
  END CATCH
    RETURN @RC;
END
GO

-- Patients/Procedures/Update/Test
DECLARE @Status INT;
DECLARE @PatientLastID INT = IDENT_CURRENT('Patients')
EXEC @Status = pUpdPatients 
@PatientID = @PatientLastID,
@PatientFirstName = 'Patient',
@PatientLastName = 'Choi',
@PatientPhoneNumber = '010-123-1231',
@PatientAddress = 'Hello Seattle',
@PatientCity = 'Seattle',
@PatientState = 'WA',
@PatientZipCode = '12345-7890'
SELECT CASE @Status
    WHEN +1 THEN 'Update was successful!'
    WHEN -1 THEN 'Update Failed! Common Issues: Duplicate Data'
    END AS [Status]
SELECT [Updated Attempt Patients ID Was:] = @@IDENTITY
SELECT *
FROM vPatients;
GO

---- Patients/Procedures/Delete
CREATE PROCEDURE pDelPatients
    (@PatientID INT)
/* Author: Minseok Choi
** Desc: Processes deleting new Patient into Patients table
** Change Log: When,Who,What
** 2021-02-29,Minseok choi,Created stored procedure.
*/
AS
BEGIN
    DECLARE @RC int = 0;
    BEGIN TRY
   BEGIN TRANSACTION 
    DELETE Patients 
	WHERE PatientID = @PatientID
   COMMIT TRANSACTION
   SET @RC = +1
  END TRY
  BEGIN CATCH
   IF(@@Trancount > 0) ROLLBACK TRANSACTION
   PRINT Error_Message();
   SET @RC = -1
  END CATCH
    RETURN @RC;
END
GO

-- Patients/Procedures/Delete/Test
DECLARE @Status INT;
DECLARE @PatientLastID INT = IDENT_CURRENT('Patients')
EXEC @Status = pDelPatients 
@PatientID = @PatientLastID
SELECT CASE @Status
    WHEN +1 THEN 'Delete was successful!'
    WHEN -1 THEN 'Delete Failed! Common Issues: Duplicate Data'
    END AS [Status]
SELECT [Deleted Attempt Patients ID Was:] = @@IDENTITY
SELECT *
FROM vPatients;
GO

--*******************************************************************************************************************
-- Doctors
--*******************************************************************************************************************
-- Doctors/Tables
CREATE TABLE dbo.Doctors
(
    DoctorID INT CONSTRAINT pkDoctor PRIMARY KEY NOT NULL IDENTITY(1,1),
    DoctorFirstName NVARCHAR(100) NOT NULL,
    DoctorLastName NVARCHAR(100) NOT NULL,
    DoctorPhoneNumber NVARCHAR(100) CONSTRAINT ckDoctorPhoneNumber CHECK (DoctorPhoneNumber LIKE '[0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]') NOT NULL,
    DoctorAddress NVARCHAR(100) NOT NULL,
    DoctorCity NVARCHAR(100) NOT NULL,
    DoctorState NVARCHAR(2) NOT NULL,
    DoctorZipCode NVARCHAR(10) CONSTRAINT ckDoctorZipCode CHECK (DoctorZipCode LIKE '[0-9][0-9][0-9][0-9][0-9]' OR
            DoctorZipCode LIKE '[0-9][0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]') NOT NULL
)

-- Doctors/Views
GO
CREATE VIEW [dbo].[vDoctors]
/* Author: Minseok Choi
** Desc: Show all data from Doctors table
** Change Log: When,Who,What
** 2021-02-29,Minseok choi,Created View.
*/
WITH
    SCHEMABINDING
AS
    SELECT
        [DoctorID],
        [DoctorFirstName],
        [DoctorLastName],
        [DoctorPhoneNumber],
        [DoctorAddress],
        [DoctorCity],
        [DoctorState],
        [DoctorZipCode]
    FROM [dbo].[Doctors]
GO

---- Doctors/Procedures/Insert
CREATE PROCEDURE pInsDoctors
    (@DoctorID INT OUTPUT,
    @DoctorFirstName NVARCHAR(100),
    @DoctorLastName NVARCHAR(100) ,
    @DoctorPhoneNumber NVARCHAR(100) ,
    @DoctorAddress NVARCHAR(100) ,
    @DoctorCity NVARCHAR(100) ,
    @DoctorState NVARCHAR(2) ,
    @DoctorZipCode NVARCHAR(10))
/* Author: Minseok Choi
** Desc: Processes inserting new Doctor into Doctors table and captures newly created Doctor.
** Change Log: When,Who,What
** 2021-02-29,Minseok choi,Created stored procedure.
*/
AS
BEGIN
    DECLARE @RC int = 0;
    BEGIN TRY
   BEGIN TRANSACTION 
    INSERT INTO Doctors
        (DoctorFirstName, DoctorLastName, DoctorPhoneNumber, DoctorAddress, DoctorCity, DoctorState, DoctorZipCode)
    VALUES(@DoctorFirstName, @DoctorLastName, @DoctorPhoneNumber, @DoctorAddress, @DoctorCity, @DoctorState, @DoctorZipCode)
    SELECT @DoctorID = SCOPE_IDENTITY();
   COMMIT TRANSACTION
   SET @RC = +1
  END TRY
  BEGIN CATCH
   IF(@@Trancount > 0) ROLLBACK TRANSACTION
   PRINT Error_Message();
   SET @RC = -1
  END CATCH
    RETURN @RC;
END
GO

-- Doctors/Procedures/Insert/Test
DECLARE @InsertedDoctorID INT;
DECLARE @Status INT;
EXEC @Status = pInsDoctors
@DoctorID = @InsertedDoctorID OUTPUT,
@DoctorFirstName = 'Doctor',
@DoctorLastName = 'CHOI',
@DoctorPhoneNumber = '010-234-1231',
@DoctorAddress = 'Hello Earth',
@DoctorCity = 'Seattle',
@DoctorState = 'WA',
@DoctorZipCode = '12345-7890'
SELECT CASE @Status
    WHEN +1 THEN 'Insert was successful!'
    WHEN -1 THEN 'Insert Failed! Common Issues: Duplicate Data'
    END AS [Status]
SELECT [Inserted Attempt Doctor ID Was:] = @InsertedDoctorID
SELECT *
FROM vDoctors;
GO


---- Doctors/Procedures/Update
CREATE PROCEDURE pUpdDoctors
    (@DoctorID INT,
    @DoctorFirstName NVARCHAR(100),
    @DoctorLastName NVARCHAR(100) ,
    @DoctorPhoneNumber NVARCHAR(100) ,
    @DoctorAddress NVARCHAR(100) ,
    @DoctorCity NVARCHAR(100) ,
    @DoctorState NVARCHAR(2) ,
    @DoctorZipCode NVARCHAR(10))
/* Author: Minseok Choi
** Desc: Processes updating new Doctor into Doctors table
** Change Log: When,Who,What
** 2021-02-29,Minseok choi,Created stored procedure.
*/
AS
BEGIN
    DECLARE @RC int = 0;
    BEGIN TRY
   BEGIN TRANSACTION 
    UPDATE Doctors SET DoctorFirstName = @DoctorFirstName, DoctorLastName = @DoctorLastName, DoctorPhoneNumber = @DoctorPhoneNumber, DoctorAddress = @DoctorAddress, DoctorCity = @DoctorCity, DoctorState = @DoctorState, DoctorZipCode = @DoctorZipCode
	WHERE DoctorID = @DoctorID
   COMMIT TRANSACTION
   SET @RC = +1
  END TRY
  BEGIN CATCH
   IF(@@Trancount > 0) ROLLBACK TRANSACTION
   PRINT Error_Message();
   SET @RC = -1
  END CATCH
    RETURN @RC;
END
GO

-- Doctors/Procedures/Update/Test
DECLARE @Status INT;
DECLARE @DoctorLastID INT = IDENT_CURRENT('Doctors')
EXEC @Status = pUpdDoctors 
@DoctorID = @DoctorLastID,
@DoctorFirstName = 'Changed Doctor',
@DoctorLastName = 'Changed Choi',
@DoctorPhoneNumber = '010-123-1231',
@DoctorAddress = 'Changed Hello Seattle',
@DoctorCity = 'Changed Seattle',
@DoctorState = 'WA',
@DoctorZipCode = '12345-7890'
SELECT CASE @Status
    WHEN +1 THEN 'Update was successful!'
    WHEN -1 THEN 'Update Failed! Common Issues: Duplicate Data'
    END AS [Status]
SELECT [Updated Attempt Doctors ID Was:] = @@IDENTITY
SELECT *
FROM vDoctors;
GO

---- Doctors/Procedures/Delete
CREATE PROCEDURE pDelDoctors
    (@DoctorID INT)
/* Author: Minseok Choi
** Desc: Processes deleting new Doctor into Doctors table
** Change Log: When,Who,What
** 2021-02-29,Minseok choi,Created stored procedure.
*/
AS
BEGIN
    DECLARE @RC int = 0;
    BEGIN TRY
   BEGIN TRANSACTION 
    DELETE Doctors 
	WHERE DoctorID = @DoctorID
   COMMIT TRANSACTION
   SET @RC = +1
  END TRY
  BEGIN CATCH
   IF(@@Trancount > 0) ROLLBACK TRANSACTION
   PRINT Error_Message();
   SET @RC = -1
  END CATCH
    RETURN @RC;
END
GO

-- Doctors/Procedures/Delete/Test
DECLARE @Status INT;
DECLARE @DoctorLastID INT = IDENT_CURRENT('Doctors')
EXEC @Status = pDelDoctors 
@DoctorID = @DoctorLastID
SELECT CASE @Status
    WHEN +1 THEN 'Delete was successful!'
    WHEN -1 THEN 'Delete Failed! Common Issues: Duplicate Data'
    END AS [Status]
SELECT [Deleted Attempt Doctors ID Was:] = @@IDENTITY
SELECT *
FROM vDoctors;
GO

--*******************************************************************************************************************
-- Appointments
--*******************************************************************************************************************
-- Appointments/Tables
CREATE TABLE dbo.Appointments
(
    AppointmentID INT CONSTRAINT pkAppointment PRIMARY KEY NOT NULL IDENTITY(1,1),
    AppointmentDateTime DATETIME NOT NULL,
    AppointmentPatientID INT CONSTRAINT fkAppointmentsToPatients FOREIGN KEY REFERENCES Patients(PatientID) NOT NULL,
    AppointmentDoctorID INT CONSTRAINT fkAppointmentsToDoctors FOREIGN KEY REFERENCES Doctors(DoctorID) NOT NULL,
    AppointmentClinicID INT CONSTRAINT fkAppointmentsToClinics FOREIGN KEY REFERENCES Clinics(ClinicID) NOT NULL
)

-- Appointments/Views
GO
CREATE VIEW [dbo].[vAppointments]
/* Author: Minseok Choi
** Desc: Show all data from Appointments table
** Change Log: When,Who,What
** 2021-02-29,Minseok choi,Created View.
*/
WITH
    SCHEMABINDING
AS
    SELECT
        [AppointmentID],
        [AppointmentDateTime],
        [AppointmentPatientID],
        [AppointmentDoctorID],
        [AppointmentClinicID]
    FROM [dbo].[Appointments]
GO

---- Appointments/Procedures/Insert
CREATE PROCEDURE pInsAppointments
    (@AppointmentID INT OUTPUT,
    @AppointmentDateTime DATETIME,
    @AppointmentPatientID INT,
    @AppointmentDoctorID INT,
    @AppointmentClinicID INT)
/* Author: Minseok Choi
** Desc: Processes inserting new Appointment into Appointments table and captures newly created Appointment.
** Change Log: When,Who,What
** 2021-02-29,Minseok choi,Created stored procedure.
*/
AS
BEGIN
    DECLARE @RC int = 0;
    BEGIN TRY
   BEGIN TRANSACTION 
    INSERT INTO Appointments
        (AppointmentDateTime, AppointmentPatientID, AppointmentDoctorID, AppointmentClinicID)
    VALUES(@AppointmentDateTime, @AppointmentPatientID, @AppointmentDoctorID, @AppointmentClinicID)
    SELECT @AppointmentID = SCOPE_IDENTITY();
   COMMIT TRANSACTION
   SET @RC = +1
  END TRY
  BEGIN CATCH
   IF(@@Trancount > 0) ROLLBACK TRANSACTION
   PRINT Error_Message();
   SET @RC = -1
  END CATCH
    RETURN @RC;
END
GO

-- Appointments/Procedures/Insert/Test


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Inserting data to test Appointments Procedures
DECLARE @InsertedClinicID INT;
DECLARE @Status INT;
EXEC @Status = pInsClinics 
@ClinicID = @InsertedClinicID OUTPUT,
@ClinicName = 'MINSEOK CLINIC 2',
@ClinicPhoneNumber ='010-234-2341',
@ClinicAddress='1231231',
@ClinicCity='seattle',
@ClinicState='WA',
@ClinicZipCode='12345-7890'
SELECT CASE @Status
    WHEN +1 THEN 'Insert was successful!'
    WHEN -1 THEN 'Insert Failed! Common Issues: Duplicate Data'
    END AS [Status]
SELECT [Inserted Attempt Clinics ID Was:] = @InsertedClinicID

GO
DECLARE @InsertedClinicID INT;
DECLARE @Status INT;
EXEC @Status = pInsClinics 
@ClinicID = @InsertedClinicID OUTPUT,
@ClinicName = 'MINSEOK CLINIC 3',
@ClinicPhoneNumber ='010-234-2341',
@ClinicAddress='1231231',
@ClinicCity='seattle',
@ClinicState='WA',
@ClinicZipCode='12345-7890'
SELECT CASE @Status
    WHEN +1 THEN 'Insert was successful!'
    WHEN -1 THEN 'Insert Failed! Common Issues: Duplicate Data'
    END AS [Status]
SELECT [Inserted Attempt Clinics ID Was:] = @InsertedClinicID
SELECT *
FROM vClinics

GO
DECLARE @InsertedDoctorID INT;
DECLARE @Status INT;
EXEC @Status = pInsDoctors
@DoctorID = @InsertedDoctorID OUTPUT,
@DoctorFirstName = 'Doctor',
@DoctorLastName = 'CHOI',
@DoctorPhoneNumber = '010-234-1231',
@DoctorAddress = 'Hello Earth',
@DoctorCity = 'Seattle',
@DoctorState = 'WA',
@DoctorZipCode = '12345-7890'
SELECT CASE @Status
    WHEN +1 THEN 'Insert was successful!'
    WHEN -1 THEN 'Insert Failed! Common Issues: Duplicate Data'
    END AS [Status]
SELECT [Inserted Attempt Doctor ID Was:] = @InsertedDoctorID
GO

DECLARE @InsertedDoctorID INT;
DECLARE @Status INT;
EXEC @Status = pInsDoctors
@DoctorID = @InsertedDoctorID OUTPUT,
@DoctorFirstName = 'Doctor 2',
@DoctorLastName = 'CHOI 2',
@DoctorPhoneNumber = '010-234-1231',
@DoctorAddress = 'Hello Earth',
@DoctorCity = 'Seattle',
@DoctorState = 'WA',
@DoctorZipCode = '12345-7890'
SELECT CASE @Status
    WHEN +1 THEN 'Insert was successful!'
    WHEN -1 THEN 'Insert Failed! Common Issues: Duplicate Data'
    END AS [Status]
SELECT [Inserted Attempt Doctor ID Was:] = @InsertedDoctorID
SELECT *
FROM vDoctors;
GO

DECLARE @InsertedPatientID INT;
DECLARE @Status INT;
EXEC @Status = pInsPatients 
@PatientID = @InsertedPatientID OUTPUT,
@PatientFirstName = 'FELIPE',
@PatientLastName = 'CHOI',
@PatientPhoneNumber = '010-234-1231',
@PatientAddress = 'Hello Earth',
@PatientCity = 'Seattle',
@PatientState = 'WA',
@PatientZipCode = '12345-7890'
SELECT CASE @Status
    WHEN +1 THEN 'Insert was successful!'
    WHEN -1 THEN 'Insert Failed! Common Issues: Duplicate Data'
    END AS [Status]
SELECT [Inserted Attempt Patient ID Was:] = @InsertedPatientID
GO

DECLARE @InsertedPatientID INT;
DECLARE @Status INT;
EXEC @Status = pInsPatients 
@PatientID = @InsertedPatientID OUTPUT,
@PatientFirstName = 'FELIPE 2',
@PatientLastName = 'CHOI 2',
@PatientPhoneNumber = '010-234-1231',
@PatientAddress = 'Hello Earth',
@PatientCity = 'Seattle',
@PatientState = 'WA',
@PatientZipCode = '12345-7890'
SELECT CASE @Status
    WHEN +1 THEN 'Insert was successful!'
    WHEN -1 THEN 'Insert Failed! Common Issues: Duplicate Data'
    END AS [Status]
SELECT [Inserted Attempt Patient ID Was:] = @InsertedPatientID
SELECT *
FROM vPatients;
GO
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

DECLARE @InsertedAppointmentID INT;
DECLARE @Status INT;
DECLARE @VarDateTime DATETIME;
SET @VarDateTime = CONVERT(VARCHAR,'12/30/2013',103);
EXEC @Status = pInsAppointments
@AppointmentID = @InsertedAppointmentID OUTPUT,
@AppointmentDateTime = @VarDateTime,
@AppointmentPatientID = 2,
@AppointmentDoctorID = 2,
@AppointmentClinicID = 2
SELECT CASE @Status
    WHEN +1 THEN 'Insert was successful!'
    WHEN -1 THEN 'Insert Failed! Common Issues: Duplicate Data'
    END AS [Status]
SELECT [Inserted Attempt Appointment ID Was:] = @InsertedAppointmentID
SELECT *
FROM vAppointments;
GO


---- Appointments/Procedures/Update
CREATE PROCEDURE pUpdAppointments
    (@AppointmentID INT,
    @AppointmentDateTime DATETIME,
    @AppointmentPatientID INT,
    @AppointmentDoctorID INT,
    @AppointmentClinicID INT)
/* Author: Minseok Choi
** Desc: Processes updating new Appointment into Appointments table
** Change Log: When,Who,What
** 2021-02-29,Minseok choi,Created stored procedure.
*/
AS
BEGIN
    DECLARE @RC int = 0;
    BEGIN TRY
   BEGIN TRANSACTION 
    UPDATE Appointments SET AppointmentDateTime = @AppointmentDateTime, AppointmentPatientID = @AppointmentPatientID, AppointmentDoctorID = @AppointmentDoctorID, AppointmentClinicID = @AppointmentClinicID
	WHERE AppointmentID = @AppointmentID
   COMMIT TRANSACTION
   SET @RC = +1
  END TRY
  BEGIN CATCH
   IF(@@Trancount > 0) ROLLBACK TRANSACTION
   PRINT Error_Message();
   SET @RC = -1
  END CATCH
    RETURN @RC;
END
GO

-- Appointments/Procedures/Update/Test
DECLARE @Status INT;
DECLARE @AppointmentLastID INT = IDENT_CURRENT('Appointments');
DECLARE @VarDateTime DATETIME;
SET @VarDateTime = CONVERT(VARCHAR,'12/30/2013',103);
EXEC @Status = pUpdAppointments
@AppointmentID = @AppointmentLastID,
@AppointmentDateTime = @VarDateTime,
@AppointmentPatientID = 3,
@AppointmentDoctorID = 3,
@AppointmentClinicID = 3
SELECT CASE @Status
    WHEN +1 THEN 'Update was successful!'
    WHEN -1 THEN 'Update Failed! Common Issues: Duplicate Data'
    END AS [Status]
SELECT [Updated Attempt Appointments ID Was:] = @@IDENTITY
SELECT *
FROM vAppointments;
GO

---- Appointments/Procedures/Delete
CREATE PROCEDURE pDelAppointments
    (@AppointmentID INT)
/* Author: Minseok Choi
** Desc: Processes deleting new Appointment into Appointments table
** Change Log: When,Who,What
** 2021-02-29,Minseok choi,Created stored procedure.
*/
AS
BEGIN
    DECLARE @RC int = 0;
    BEGIN TRY
   BEGIN TRANSACTION 
    DELETE Appointments 
	WHERE AppointmentID = @AppointmentID
   COMMIT TRANSACTION
   SET @RC = +1
  END TRY
  BEGIN CATCH
   IF(@@Trancount > 0) ROLLBACK TRANSACTION
   PRINT Error_Message();
   SET @RC = -1
  END CATCH
    RETURN @RC;
END
GO

-- Appointments/Procedures/Delete/Test
DECLARE @Status INT;
DECLARE @AppointmentLastID INT = IDENT_CURRENT('Appointments')
EXEC @Status = pDelAppointments
@AppointmentID = @AppointmentLastID
SELECT CASE @Status
    WHEN +1 THEN 'Delete was successful!'
    WHEN -1 THEN 'Delete Failed! Common Issues: Duplicate Data'
    END AS [Status]
SELECT [Deleted Attempt Appointments ID Was:] = @@IDENTITY
SELECT *
FROM vAppointments;
GO


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Inserting Appointments to test reporting view
DECLARE @InsertedAppointmentID INT;
DECLARE @Status INT;
DECLARE @VarDateTime DATETIME;
SET @VarDateTime = CONVERT(VARCHAR,'12/30/2013 14:24:35',103);
EXEC @Status = pInsAppointments
@AppointmentID = @InsertedAppointmentID OUTPUT,
@AppointmentDateTime = @VarDateTime,
@AppointmentPatientID = 2,
@AppointmentDoctorID = 2,
@AppointmentClinicID = 2
SELECT CASE @Status
    WHEN +1 THEN 'Insert was successful!'
    WHEN -1 THEN 'Insert Failed! Common Issues: Duplicate Data'
    END AS [Status]
SELECT [Inserted Attempt Appointment ID Was:] = @InsertedAppointmentID

GO
DECLARE @InsertedAppointmentID INT;
DECLARE @Status INT;
DECLARE @VarDateTime DATETIME;
SET @VarDateTime = CONVERT(VARCHAR,'2/11/2021 15:12:34',103);
EXEC @Status = pInsAppointments
@AppointmentID = @InsertedAppointmentID OUTPUT,
@AppointmentDateTime = @VarDateTime,
@AppointmentPatientID = 2,
@AppointmentDoctorID = 3,
@AppointmentClinicID = 2
SELECT CASE @Status
    WHEN +1 THEN 'Insert was successful!'
    WHEN -1 THEN 'Insert Failed! Common Issues: Duplicate Data'
    END AS [Status]
SELECT [Inserted Attempt Appointment ID Was:] = @InsertedAppointmentID
GO

DECLARE @InsertedAppointmentID INT;
DECLARE @Status INT;
DECLARE @VarDateTime DATETIME;
SET @VarDateTime = CONVERT(VARCHAR,'09/03/2020 12:23:11',103);
EXEC @Status = pInsAppointments
@AppointmentID = @InsertedAppointmentID OUTPUT,
@AppointmentDateTime = @VarDateTime,
@AppointmentPatientID = 3,
@AppointmentDoctorID = 3,
@AppointmentClinicID = 3
SELECT CASE @Status
    WHEN +1 THEN 'Insert was successful!'
    WHEN -1 THEN 'Insert Failed! Common Issues: Duplicate Data'
    END AS [Status]
SELECT [Inserted Attempt Appointment ID Was:] = @InsertedAppointmentID
SELECT *
FROM vAppointments;
GO
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Appointments/View
CREATE VIEW [dbo].[vAppointmentsByPatientsDoctorsAndClinics]
/* Author: Minseok Choi
** Desc: Show reportting view for all tables from Appointments by Patients, Doctors and Clinics
** Change Log: When,Who,What
** 2021-02-29,Minseok choi,Created View.
*/
AS
    SELECT
        A.[AppointmentID],
        [AppointmentDate] = FORMAT(A.AppointmentDateTime, 'd', 'en-US'),
        [AppointmentTime] = FORMAT(A.AppointmentDateTime, 'hh:mm'),
        P.[PatientID],
        [PatientName] = P.[PatientFirstName] + ' ' + P.[PatientLastName],
        P.[PatientPhoneNumber],
        P.[PatientAddress],
        P.[PatientCity],
        P.[PatientState],
        P.[PatientZipCode],
        D.[DoctorID],
        [DoctorName] = D.[DoctorFirstName] + ' ' + D.[DoctorLastName],
        D.[DoctorPhoneNumber],
        D.[DoctorAddress],
        D.[DoctorCity],
        D.[DoctorState],
        D.[DoctorZipCode],
        C.[ClinicID],
        C.[ClinicName],
        C.[ClinicPhoneNumber],
        C.[ClinicAddress],
        C.[ClinicCity],
        C.[ClinicState],
        C.[ClinicZipCode]
    FROM [dbo].[Appointments] AS A
        INNER JOIN [dbo].[Clinics] AS C
        ON A.[AppointmentClinicID] = C.[ClinicID]
        INNER JOIN [dbo].[Patients] AS P
        ON A.[AppointmentPatientID] = P.[PatientID]
        INNER JOIN [dbo].[Doctors] AS D
        ON A.[AppointmentDoctorID] = D.[DoctorID]
GO

SELECT *
FROM dbo.vAppointmentsByPatientsDoctorsAndClinics;
GO

-- Set permission for tables, views, and stored procedures 
-- Clinics
Deny SELECT, INSERT, UPDATE, DELETE ON Clinics TO Public;
GRANT SELECT ON vClinics TO Public;
GRANT EXECUTE ON pInsClinics TO Public;
GRANT EXECUTE ON pUpdClinics TO Public;
GRANT EXECUTE ON pDelClinics TO Public;
GO
-- Patients
Deny SELECT, INSERT, UPDATE, DELETE ON Patients TO Public;
GRANT SELECT ON vPatients TO Public;
GRANT EXECUTE ON pInsPatients TO Public;
GRANT EXECUTE ON pUpdPatients TO Public;
GRANT EXECUTE ON pDelPatients TO Public;
GO
-- Doctors
Deny SELECT, INSERT, UPDATE, DELETE ON Doctors TO Public;
GRANT SELECT ON vDoctors TO Public;
GRANT EXECUTE ON pInsDoctors TO Public;
GRANT EXECUTE ON pUpdDoctors TO Public;
GRANT EXECUTE ON pDelDoctors TO Public;
GO

-- Appointments
Deny SELECT, INSERT, UPDATE, DELETE ON Appointments TO Public;
GRANT SELECT ON vAppointments TO Public;
GRANT EXECUTE ON pInsAppointments TO Public;
GRANT EXECUTE ON pUpdAppointments TO Public;
GRANT EXECUTE ON pDelAppointments TO Public;
GO

-- Reporting View
GRANT SELECT ON vAppointmentsByPatientsDoctorsAndClinics TO Public;
GO