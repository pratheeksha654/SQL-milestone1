CREATE TABLE Patient (
    patient_id INT PRIMARY KEY,
    patient_name VARCHAR(50),
    patient_phone VARCHAR(15)
);


CREATE TABLE Department (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);



CREATE TABLE Doctor 
(
    doctor_id INT PRIMARY KEY,
    doctor_name VARCHAR(50),
    specialization VARCHAR(50),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Department(department_id)
);



CREATE TABLE Appointment (
    appointment_id INT PRIMARY KEY,
    patient_id INT,
    appointment_datetime DATETIME,
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id)
);



CREATE TABLE Consultation
(
    consultation_id INT PRIMARY KEY,
    appointment_id INT,
    notes TEXT,
    FOREIGN KEY (appointment_id) REFERENCES Appointment(appointment_id)
);


CREATE TABLE Consultation_Doctor
(
    consultation_id INT,
    doctor_id INT,
    role VARCHAR(50),
    PRIMARY KEY (consultation_id, doctor_id),
    FOREIGN KEY (consultation_id) REFERENCES Consultation(consultation_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id)
);





CREATE TABLE Medicine (
    medicine_id INT PRIMARY KEY,
    medicine_name VARCHAR(50),
    price DECIMAL(10,2)
);



CREATE TABLE Prescription (
    prescription_id INT PRIMARY KEY,
    consultation_id INT,
    medicine_id INT,
    dosage VARCHAR(50),
    duration VARCHAR(50),
    FOREIGN KEY (consultation_id) REFERENCES Consultation(consultation_id),
    FOREIGN KEY (medicine_id) REFERENCES Medicine(medicine_id)
);

CREATE TABLE Diagnosis (
    diagnosis_id INT PRIMARY KEY,
    consultation_id INT,
    diagnosis_text VARCHAR(100),
    
    FOREIGN KEY (consultation_id) REFERENCES Consultation(consultation_id)
);


CREATE TABLE Billing (
    bill_id INT PRIMARY KEY,
    consultation_id INT,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (consultation_id) REFERENCES Consultation(consultation_id)
);



CREATE TABLE Payment (
    payment_id INT PRIMARY KEY,
    bill_id INT,
    amount_paid DECIMAL(10,2),
    payment_date DATE,
    FOREIGN KEY (bill_id) REFERENCES Billing(bill_id)
);




INSERT INTO Patient VALUES
(1, 'John Doe', '9876543210'),
(2, 'Alice', '9123456780'),
(3, 'Rahul', '9000000001'),
(4, 'Sneha', '9000000002'),
(5, 'Arjun', '9000000003');


INSERT INTO Department VALUES
(1, 'Cardiology'),
(2, 'General'),
(3, 'Neurology'),
(4, 'Orthopedics'),
(5, 'Dermatology');



INSERT INTO Doctor VALUES
(1, 'Dr. Smith', 'Cardiologist', 1),
(2, 'Dr. Brown', 'General Physician', 2),
(3, 'Dr. Kumar', 'Neurologist', 3),
(4, 'Dr. Patel', 'Orthopedic', 4),
(5, 'Dr. Reddy', 'Dermatologist', 5);


INSERT INTO Appointment VALUES
(1, 1, '2026-04-28 10:00:00'),
(2, 2, '2026-04-28 11:00:00'),
(3, 3, '2026-04-29 09:00:00'),
(4, 4, '2026-04-29 10:30:00'),
(5, 5, '2026-04-30 09:30:00');



INSERT INTO Consultation VALUES
(1, 1, 'Routine checkup'),
(2, 2, 'Fever case'),
(3, 3, 'Headache'),
(4, 4, 'Knee pain'),
(5, 5, 'Skin allergy'),
(7, 2, 'eye pain'),
(8, 2, 'breathing'),
(9, 3, 'vomiting'),
(10, 2, 'breathing'),
(6, 1, 'Follow-up');




INSERT INTO Consultation_Doctor VALUES
(1, 1, 'Primary'),
(2, 2, 'Primary'),
(3, 3, 'Primary'),
(4, 4, 'Primary'),
(5, 5, 'Primary'),
(6, 2, 'Primary'),
(7, 2, 'Primary'),
(8, 3, 'Primary'),
(9, 2, 'Primary'),
(10, 1, 'Primary');

INSERT INTO Diagnosis VALUES
(1,1,'Normal'),
(2,2,'Fever'),
(3,3,'Headache'),
(4,4,'Pain'),
(5,5,'Allergy');




INSERT INTO Medicine VALUES
(1, 'Paracetamol', 50),
(2, 'Vitamin C', 30),
(3, 'Ibuprofen', 80),
(4, 'Calcium Tablets', 120),
(5, 'Antihistamine', 60);



INSERT INTO Prescription VALUES
(1, 1, 1, '2 times a day', '5 days'),
(2, 2, 2, '1 time a day', '7 days'),
(3, 3, 3, '3 times a day', '7 days'),
(4, 4, 4, '2 times a day', '10 days'),
(5, 5, 5, '2 times a day', '5 days');



INSERT INTO Billing VALUES
(1, 1, 500),
(2, 2, 300),
(3, 3, 700),
(4, 4, 900),
(5, 5, 400);



INSERT INTO Payment VALUES
(1, 1, 500, '2026-04-28'),
(2, 2, 100, '2026-04-28'), 
(3, 3, 700, '2026-04-29'), 
(4, 4, 200, '2026-04-29'), 
(5, 5, 0,   '2026-04-30'); 



SELECT 
    d.doctor_id,
    d.doctor_name,
    COUNT(cd.consultation_id) AS total_consultations
FROM Doctor d
JOIN Consultation_Doctor cd ON d.doctor_id = cd.doctor_id
GROUP BY d.doctor_id, d.doctor_name
ORDER BY total_consultations DESC;



SELECT 
    p.patient_name,
    SUM(b.total_amount - IFNULL(pay.amount_paid, 0)) AS pending
FROM Patient p
JOIN Appointment a ON p.patient_id = a.patient_id
JOIN Consultation c ON a.appointment_id = c.appointment_id
JOIN Billing b ON c.consultation_id = b.consultation_id
LEFT JOIN Payment pay ON b.bill_id = pay.bill_id
GROUP BY p.patient_name
HAVING SUM(b.total_amount - IFNULL(pay.amount_paid, 0)) > 0;






SELECT p.patient_name, d.doctor_name, m.medicine_name
FROM Patient p
JOIN Appointment a ON p.patient_id=a.patient_id
JOIN Consultation c ON a.appointment_id=c.appointment_id
JOIN Consultation_Doctor cd ON c.consultation_id=cd.consultation_id
JOIN Doctor d ON cd.doctor_id=d.doctor_id
LEFT JOIN Prescription pr ON c.consultation_id=pr.consultation_id
LEFT JOIN Medicine m ON pr.medicine_id=m.medicine_id;


