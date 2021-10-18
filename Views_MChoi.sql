--**********************************************************************************************--
-- Title: Final Assignment: Milstone 03
-- Author: MinseokChoi
-- Desc: This file designs and creates reporting views
-- for patients appointments application. 
-- Change Log: When,Who,What
-- 2021-03-07,MinseokChoi,Created File
--***********************************************************************************************--
USE FinalDB_MinseokChoi;
GO

-- Creating Reporting Views
-- To see general information of tables
EXEC sp_help Clinics;
EXEC sp_help Doctors;
EXEC sp_help Patients;
EXEC sp_help Appointments;

SELECT *
FROM [dbo].[vAppointmentsByPatientsDoctorsAndClinics];
GO
---- View/number of each patient's appointments
CREATE VIEW [dbo].[vAppointmentsNumberByPatients]
/* Author: Minseok Choi
** Desc: Show reportting view for each patient's appointment count
** Change Log: When,Who,What
** 2021-03-07,Minseok choi,Created View.
*/
AS
    SELECT
        [PatientName] = P.[PatientFirstName] + ' ' + P.[PatientLastName],
        [PatientPhoneNumber],
        [PatientAddress],
        [PatientCity],
        [PatientState],
        [PatientZipCode],
        [NumberOfAppointments] = COUNT(*)
    FROM [dbo].[Appointments] AS A
        INNER JOIN [dbo].[Patients] AS P
        ON A.[AppointmentPatientID] = P.[PatientID]
    GROUP BY P.[PatientFirstName], P.[PatientLastName], P.[PatientPhoneNumber], P.[PatientAddress],
        P.[PatientCity], P.[PatientState], P.[PatientZipCode]
GO

SELECT *
FROM vAppointmentsNumberByPatients;

GO
---- View/number of appointments for each year where it's doctors state is from California. 
CREATE VIEW [dbo].[vAppointmentsNumberByYear]
/* Author: Minseok Choi
** Desc: Show reporting view for number of appointments for each year where it's doctors state is from California. 
** Change Log: When,Who,What
** 2021-03-07,Minseok choi,Created View.
*/
AS
    SELECT
        [AppointmentYear] = YEAR(A.AppointmentDateTime),
        [NumberOfAppointments] = COUNT(*)
    FROM [dbo].[Appointments] AS A
        INNER JOIN [dbo].[Doctors] AS D
        ON A.[AppointmentDoctorID] = D.[DoctorID]
    WHERE D.[DoctorState] = 'CA'
    GROUP BY YEAR(A.AppointmentDateTime)
GO

SELECT *
FROM vAppointmentsNumberByYear;

