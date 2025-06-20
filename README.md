# 🧬 Clinical Trial DVT Database – SQL Project

This project simulates a real-world clinical trial database for treating **Calf Deep Vein Thrombosis (DVT)** using **Apixaban**, modeled after an actual trial ([NCT03590743](https://clinicaltrials.gov/study/NCT03590743)). The database is fully normalized and includes schema creation, mock data, triggers, stored procedures, and analytical queries.

---

## 🧠 Project Summary

This mock clinical database captures patient data, health metrics, treatment plans, adverse events, and imaging follow-ups. It's designed for teaching relational database design, SQL programming, and data integrity in clinical research settings.

- 5 relational tables
- 1-to-many relationships from Participants to each domain
- Data types include ENUMs, DECIMAL, DATETIME, VARCHAR, etc.
- Designed using MySQL Workbench

---

## 🗃️ Database Features

- ✅ Normalized schema (3NF)
- ✅ Full integrity constraints & foreign keys
- ✅ Realistic mock data for all tables
- ✅ Auto-incrementing IDs
- ✅ Check constraints & enums

---

## ⚙️ SQL Functionality

### 🔧 Triggers
- `before_insert_participant_email`  
  Auto-formats participant email to lowercase before insert

### 🧠 Stored Procedures
- `sp_InsertParticipant` – Add participant with validations  
- `sp_GetParticipantHealthSummary` – Returns latest health metrics  
- `sp_ReportAdverseEvents` – Filters adverse events by severity  
- `sp_GetImagingFollowUp` – Retrieves follow-up imaging (filterable)

### 📊 Sample Queries
- Average BMI, grouped by gender  
- All adverse events after Day 10  
- JOINed summaries of participant health, treatment, and imaging  
- Nested logic using CASE statements

---

## 🖼 ERD Diagram

![ERD Diagram](DVT%20-%20ERD.png)

---

## 📁 Files Included

| File | Description |
|------|-------------|
| `DVT-Database.sql` | Full SQL script – schema, data, triggers, procedures, queries |
| `DVT – ERD.drawio.pdf` | ERD with labels and cardinality |
| `DVT – ERD.png` | Quick visual reference of ERD |
| `DVT-ERD.mwb` | MySQL Workbench model |
| `DVT – ERD.drawio` | Editable ERD file (draw.io) |

---

## 👥 Team Contributions

| Team Member | Role |
|-------------|------|
| **Jorge Juarez** | Schema design, foreign keys, queries, testing |
| **Joel Prosper** | INSERT statements, trigger logic |
| **Michael Sam** | ERD creation, documentation, stored procedures |

---

📌 *Submitted for LIS 5683 – Advanced Database Systems @ University of Oklahoma*
