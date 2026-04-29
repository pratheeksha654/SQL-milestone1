

CREATE TABLE Patient (
    patient_id INT PRIMARY KEY,
    patient_name VARCHAR(50),
    patient_phone VARCHAR(15) UNIQUE
);



CREATE TABLE Department
(
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);



CREATE TABLE Doctor
(
    doctor_id INT PRIMARY KEY,
    doctor_name VARCHAR(50),
    doctor_specialization VARCHAR(50),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Department(department_id)
);




CREATE TABLE Appointment (
    appointment_id INT PRIMARY KEY,
    patient_id INT   ,
    doctor_id INT   ,
    appointment_date DATE,
    diagnosis TEXT,
    treatment TEXT,
    prescription_details TEXT,
   FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
   FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id)
);
DROP TABLE IF EXISTS APPOINTMENT;
CREATE TABLE Medicine (
    medicine_id INT PRIMARY KEY,
    medicine_name VARCHAR(50),
    medicine_price DECIMAL(10,2)
);

CREATE TABLE Prescription (
    prescription_id INT PRIMARY KEY,
    appointment_id INT,
    medicine_id INT,
    FOREIGN KEY (appointment_id) REFERENCES Appointment(appointment_id),
    FOREIGN KEY (medicine_id) REFERENCES Medicine(medicine_id)
);


CREATE TABLE Admission (
    admission_id INT PRIMARY KEY,
    patient_id INT,
    room_no INT,
    admission_date DATE,
    discharge_date DATE,

    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
    FOREIGN KEY (room_no) REFERENCES Room(room_no)
);
CREATE TABLE Payment (
    payment_id INT PRIMARY KEY,
    appointment_id INT,
    bill_amount DECIMAL(10,2),
    payment_status VARCHAR(20),
    payment_method VARCHAR(20),
    payment_date DATE,
    FOREIGN KEY (appointment_id) REFERENCES Appointment(appointment_id)
);

CREATE TABLE Room (
    room_no INT PRIMARY KEY,
    room_type VARCHAR(50)
);

































