-- Create Staging Database
CREATE DATABASE Hospital_Staging;
GO
USE Hospital_Staging;
GO

-- ------------------------
-- Table: admission
-- ------------------------
CREATE TABLE admission (
    admission_id int,
    patient_id int,
    department_id int,
    ward_id int,
    bed_id int,
    disease_id int,
    admission_date DATETIME,
    discharge_date DATETIME,
    admission_type nvarchar(MAX),
    admission_status nvarchar(MAX)
);

-- ------------------------
-- Table: bed
-- ------------------------
CREATE TABLE bed (
    bed_id int,
    ward_id int,
    bed_number nvarchar(MAX),
    bed_status nvarchar(MAX)
);

-- ------------------------
-- Table: billing
-- ------------------------
CREATE TABLE billing (
    bill_id int,
    total_amount int,
    insurance_covered_amount float,
    patient_payable_amount float,
    admission_id int,
    bill_date DATETIME,
    payment_status nvarchar(MAX),
    payment_mode nvarchar(MAX)
);

-- ------------------------
-- Table: billing_detail
-- ------------------------
CREATE TABLE billing_detail (
    billing_detail_id int,
    reference_id float,
    amount int,
    bill_id int,
    charge_type nvarchar(MAX)
);

-- ------------------------
-- Table: department
-- ------------------------
CREATE TABLE department (
    department_id int,
    floor_number int,
    department_name nvarchar(MAX),
    department_type nvarchar(MAX),
    status nvarchar(MAX)
);

-- ------------------------
-- Table: diagnostic_test
-- ------------------------
CREATE TABLE diagnostic_test (
    test_id int,
    standard_cost int,
    department_id int,
    test_name nvarchar(MAX),
    test_category nvarchar(MAX)
);

-- ------------------------
-- Table: disease
-- ------------------------
CREATE TABLE disease (
    disease_id int,
    disease_name nvarchar(MAX),
    disease_category nvarchar(MAX)
);

-- ------------------------
-- Table: doctor
-- ------------------------
CREATE TABLE doctor (
    doctor_id int,
    employee_id int,
    experience_years int,
    specialization nvarchar(MAX),
    qualification nvarchar(MAX)
);

-- ------------------------
-- Table: drug
-- ------------------------
CREATE TABLE drug (
    drug_id int,
    unit_cost int,
    manufacturer_id int,
    drug_name nvarchar(MAX),
    brand_name nvarchar(MAX),
    drug_category nvarchar(MAX)
);

-- ------------------------
-- Table: drug_inventory
-- ------------------------
CREATE TABLE drug_inventory (
    inventory_id int,
    current_stock int,
    reorder_level int,
    drug_id int,
    inventory_status nvarchar(MAX),
    last_restock_date DATETIME
);

-- ------------------------
-- Table: drug_manufacturer
-- ------------------------
CREATE TABLE drug_manufacturer (
    manufacturer_id int,
    reliability_rating float,
    manufacturer_name nvarchar(MAX),
    country nvarchar(MAX),
    contract_status nvarchar(MAX)
);

-- ------------------------
-- Table: employee
-- ------------------------
CREATE TABLE employee (
    employee_id int,
    department_id int,
    employee_name nvarchar(MAX),
    gender nvarchar(MAX),
    role nvarchar(MAX),
    employment_type nvarchar(MAX),
    date_of_joining DATETIME
);

-- ------------------------
-- Table: insurance_provider
-- ------------------------
CREATE TABLE insurance_provider (
    insurance_provider_id int,
    contact_details int,
    coverage_limit int,
    provider_name nvarchar(MAX),
    provider_type nvarchar(MAX)
);

-- ------------------------
-- Table: patient
-- ------------------------
CREATE TABLE patient (
    patient_id int,
    gender nvarchar(MAX),
    date_of_birth DATETIME,
    blood_group nvarchar(MAX),
    city nvarchar(MAX),
    contact_number nvarchar(MAX)
);

-- ------------------------
-- Table: patient_diagnostic
-- ------------------------
CREATE TABLE patient_diagnostic (
    patient_diagnostic_id int,
    admission_id int,
    test_id int,
    doctor_id int,
    test_date DATETIME,
    result_status nvarchar(MAX)
);

-- ------------------------
-- Table: patient_insurance
-- ------------------------
CREATE TABLE patient_insurance (
    patient_insurance_id int,
    coverage_percentage int,
    patient_id int,
    insurance_provider_id int,
    policy_number nvarchar(MAX),
    policy_start_date DATETIME,
    policy_end_date DATETIME
);

-- ------------------------
-- Table: prescription
-- ------------------------
CREATE TABLE prescription (
    prescription_id int,
    duration_days int,
    admission_id int,
    drug_id int,
    dosage nvarchar(MAX),
    frequency nvarchar(MAX)
);

-- ------------------------
-- Table: staff_assignment
-- ------------------------
CREATE TABLE staff_assignment (
    assignment_id int,
    employee_id int,
    ward_id int,
    shift nvarchar(MAX)
);

-- ------------------------
-- Table: ward
-- ------------------------
CREATE TABLE ward (
    ward_id int,
    total_beds int,
    department_id int,
    ward_name nvarchar(MAX),
    ward_type nvarchar(MAX)
);

-- ------------------------
-- Table: equipment_maintenance
-- ------------------------
CREATE TABLE equipment_maintenance (
    maintenance_id int,
    equipment_id int,
    equipment_name nvarchar(MAX),
    department_id int,
    ward_id int,
    maintenance_date DATETIME,
    status nvarchar(MAX),
    downtime_hours int,
    maintenance_cost int
);

-- ------------------------
-- Table: patient_satisfaction
-- ------------------------
CREATE TABLE patient_satisfaction (
    survey_id int,
    admission_id int,
    patient_id int,
    department_id int,
    doctor_id int,
    survey_date DATETIME,
    satisfaction_score int,
    cleanliness_score int,
    staff_behavior_score int,
    wait_time_score int,
    would_recommend nvarchar(MAX)
);

