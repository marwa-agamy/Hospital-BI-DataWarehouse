CREATE DATABASE Hospital_DW;
GO
USE Hospital_DW;
GO

-------------------------------------------
-- Dimension Tables
-------------------------------------------
-- Patient Dimension
CREATE TABLE dim_patient (
    patient_key INT IDENTITY PRIMARY KEY,
    patient_id INT,
    patient_name NVARCHAR(100),
    gender NVARCHAR(10),
    date_of_birth DATE,
    blood_group NVARCHAR(5),
    city NVARCHAR(50),
    contact_number NVARCHAR(20),
    start_date DATE,
    end_date DATE,
    is_current BIT
);

-- Employee Dimension
CREATE TABLE dim_employee (
    employee_key INT IDENTITY PRIMARY KEY,
    employee_id INT,
    employee_name NVARCHAR(100),
    gender NVARCHAR(10),
    role NVARCHAR(50),
    employment_type NVARCHAR(50),
    date_of_joining DATE,
    department_name NVARCHAR(100),
    start_date DATE,
    end_date DATE,
    is_current BIT
);

-- Doctor Dimension
CREATE TABLE dim_doctor (
    doctor_key INT IDENTITY PRIMARY KEY,
    doctor_id INT,
    doctor_name NVARCHAR(100),
    specialization NVARCHAR(100),
    qualification NVARCHAR(100),
    experience_years INT,
    department_name NVARCHAR(100),
    start_date DATE,
    end_date DATE,
    is_current BIT
);

-- Department Dimension
CREATE TABLE dim_department (
    department_key INT IDENTITY PRIMARY KEY,
    department_id INT,
    department_name NVARCHAR(100),
    department_type NVARCHAR(50),
    floor_number INT,
    status NVARCHAR(20),
    start_date DATE,
    end_date DATE,
    is_current BIT
);

-- Ward Dimension
CREATE TABLE dim_ward (
    ward_key INT IDENTITY PRIMARY KEY,
    ward_id INT,
    ward_name NVARCHAR(100),
    ward_type NVARCHAR(50),
    total_beds INT,
    department_name NVARCHAR(100)
);

-- Bed Dimension
CREATE TABLE dim_bed (
    bed_key INT IDENTITY PRIMARY KEY,
    bed_id INT,
    bed_number NVARCHAR(10),
    bed_status NVARCHAR(20),
    ward_name NVARCHAR(100)
);

-- Disease Dimension
CREATE TABLE dim_disease (
    disease_key INT IDENTITY PRIMARY KEY,
    disease_id INT,
    disease_name NVARCHAR(100),
    disease_category NVARCHAR(50)
);

-- Diagnostic Test Dimension
CREATE TABLE dim_diagnostic_test (
    test_key INT IDENTITY PRIMARY KEY,
    test_id INT,
    test_name NVARCHAR(100),
    test_category NVARCHAR(50),
    standard_cost DECIMAL(12,2),
    department_name NVARCHAR(100)
);

-- Drug Dimension (denormalized with manufacturer info)
CREATE TABLE dim_drug (
    drug_key INT IDENTITY PRIMARY KEY,
    drug_id INT,
    drug_name NVARCHAR(100),
    brand_name NVARCHAR(50),
    drug_category NVARCHAR(50),
    unit_cost DECIMAL(12,2),
    manufacturer_name NVARCHAR(100),
    manufacturer_country NVARCHAR(50),
    manufacturer_reliability DECIMAL(3,2)
);

-- Insurance Provider Dimension
CREATE TABLE dim_insurance_provider (
    insurance_provider_key INT IDENTITY PRIMARY KEY,
    provider_name NVARCHAR(100),
    provider_type NVARCHAR(50),
    coverage_limit DECIMAL(12,2)
);

-- Date Dimension
CREATE TABLE dim_date (
    date_key INT PRIMARY KEY,
    full_date DATE,
    year INT,
    month INT,
    day INT,
    quarter INT,
    day_of_week NVARCHAR(10),
    is_weekend BIT
);


-----------------------------
-- Fact Tables
-----------------------------
-- Admissions Fact
CREATE TABLE fact_admission (
    admission_key INT IDENTITY PRIMARY KEY,
    patient_key INT,
    department_key INT,
    ward_key INT,
    bed_key INT,
    disease_key INT,
    admit_date_key INT,
    discharge_date_key INT,
    admission_type NVARCHAR(50),
    length_of_stay INT,
    total_charges DECIMAL(12,2)
);

-- Billing Fact
CREATE TABLE fact_billing (
    billing_key INT IDENTITY PRIMARY KEY,
    admission_key INT,                -- link to admission (patient & department info comes from here)
    insurance_provider_key INT,
    bill_date_key INT,
    total_amount DECIMAL(12,2),
    insurance_covered_amount DECIMAL(12,2),
    patient_payable_amount DECIMAL(12,2),
    payment_status NVARCHAR(50),
    payment_mode NVARCHAR(50)
);

-- Billing Detail Fact
CREATE TABLE fact_billing_detail (
    billing_detail_key INT IDENTITY PRIMARY KEY,
    billing_key INT,                  -- link to fact_billing
    charge_type NVARCHAR(50),
    amount DECIMAL(12,2)
);

-- Patient Diagnostic Fact
CREATE TABLE fact_patient_diagnostic (
    test_key INT,
    admission_key INT,
    doctor_key INT,
    test_date_key INT,
    result_status NVARCHAR(50),
    test_cost DECIMAL(12,2)
);

-- Prescription Fact
CREATE TABLE fact_prescription (
    admission_key INT,
    drug_key INT,
    dosage NVARCHAR(50),
    frequency NVARCHAR(50),
    duration_days INT
);

-- Drug Inventory Fact
CREATE TABLE fact_drug_inventory (
    drug_key INT,
    current_stock INT,
    reorder_level INT,
    inventory_status NVARCHAR(20),
    last_restock_date_key INT
);

-- Staff Assignment Fact
CREATE TABLE fact_staff_assignment (
    employee_key INT,
    ward_key INT,
    shift NVARCHAR(50)
);

-- Equipment Maintenance Fact
CREATE TABLE fact_equipment_maintenance (
    equipment_key INT,
    department_key INT,
    ward_key INT,
    date_key INT,
    downtime_hours INT,
    maintenance_cost DECIMAL(10,2)
);

-- Patient Satisfaction Fact
CREATE TABLE fact_patient_satisfaction (
    admission_key INT,
    doctor_key INT,
    department_key INT,
    date_key INT,
    satisfaction_score INT,
    cleanliness_score INT,
    staff_behavior_score INT,
    wait_time_score INT
);

