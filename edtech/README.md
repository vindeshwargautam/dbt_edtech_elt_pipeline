# End-to-End EdTech ELT Pipeline using dbt, Snowflake & dbt Cloud

A production-style Data Engineering / Analytics Engineering project where I transformed raw EdTech data into an analytics-ready warehouse using **dbt Core**, **Snowflake**, **dbt Cloud**, and **GitHub**. The project covers layered transformations, Star Schema modeling, incremental loading, SCD Type 2 snapshots, data quality testing, and basic CI/CD — pretty much the full workflow you'd expect in a real Data Engineering / Analytics Engineering setup.

## Project Overview

This project shows how a modern Data Engineering / Analytics Engineering pipeline comes together using dbt and Snowflake.

Raw operational data is loaded into Snowflake first, and then pushed through multiple transformation layers (Staging → Intermediate → Marts) to finally land as clean Dimension and Fact tables. The whole thing is automated with dbt Cloud, and I've tried to follow the same practices you'd see in an actual team setup — GitHub integration, CI checks, scheduled runs, etc.

## Business Objective

The goal here was to build a scalable ELT pipeline that lets business users actually analyze things like:

- Student Enrollment Trends
- Course Performance
- Student Learning Progress
- Instructor Information
- Payment Transactions

The final model follows a Star Schema so it's ready for reporting and dashboards without extra rework.

## Tech Stack

| Technology | Purpose |
|------------|----------|
| dbt Core | Data Transformation |
| dbt Cloud | Deployment, CI/CD & Scheduling |
| Snowflake | Cloud Data Warehouse |
| SQL | Transformation Logic |
| Git & GitHub | Version Control |
| CSV Files | Source Data |

## Architecture

```
                    CSV Files
                        │
                        ▼
              Snowflake Source Tables
                        │
                        ▼
                  Staging Layer
                        │
                        ▼
              Intermediate Layer
                        │
          ┌─────────────┴─────────────┐
          ▼                           ▼
   Dimension Tables              Fact Tables
          │                           │
          └─────────────┬─────────────┘
                        ▼
              Snapshot (SCD Type 2)
                        │
                        ▼
              Analytics & Reporting
```

## Project Structure

```
edtech/
├── analyses/
├── macros/
├── models/
│   ├── staging/
│   ├── intermediate/
│   └── marts/
│       ├── dimensions/
│       └── facts/
├── snapshots/
├── seeds/
├── tests/
├── dbt_project.yml
├── packages.yml
└── README.md
```

## Data Model

**Dimension Tables**
- dim_students
- dim_courses
- dim_instructors

**Fact Tables**
- fact_enrollments
- fact_payments
- fact_course_progress

## Layer-wise Transformations

### Staging Layer
- Reads raw source data
- Standardizes column names
- Trims unwanted spaces
- Basic cleaning
- Keeps `created_at` and `updated_at` timestamps intact

Materialization: **View**

### Intermediate Layer
- Joins multiple staging models together
- Applies business logic
- Builds analytics-ready datasets
- Uses driving tables to keep transformations efficient
- Preps data for the Star Schema

Materialization: **View**

### Mart Layer

**Dimension Models** — descriptive business entities, built as:
- Incremental Models
- Merge Strategy
- Historical tracking via Snapshots

Examples: Students, Courses, Instructors

**Fact Models** — measurable business events, built as:
- Incremental Models
- Merge Strategy

Examples: Enrollments, Payments, Course Progress

## Business Transformations Implemented

| Layer | Transformation |
|--------|----------------|
| Staging | Data cleaning, trimming, standardizing source data |
| Intermediate | Joined students, courses, enrollments, payments and progress using business keys |
| Dimensions | Built incremental dimensions using MERGE strategy |
| Facts | Created analytics-ready fact tables for reporting |
| Snapshots | Implemented SCD Type 2 using Timestamp Strategy |
| Tests | Applied dbt generic and custom data quality tests |

## Incremental Loading

Both Dimension and Fact tables use **Incremental Materialization**, which gives:
- Merge Strategy
- Unique Keys
- Faster runs
- Lower warehouse cost
- Only new/updated records get processed instead of a full reload every time

## Snapshots (SCD Type 2)

Snapshots preserve historical changes for the dimension tables.

**Strategy used:** Timestamp Strategy
**Tracked tables:** Students, Courses, Instructors

This means whenever a record changes, the old version isn't lost — it's tracked historically alongside the new one.

## Data Quality Testing

Tests implemented:
- Not Null
- Unique
- Relationships
- Accepted Values
- Custom SQL Tests

These make sure the transformed data actually holds up and stays consistent.

## Deployment

Deployment is handled through **dbt Cloud**, with:
- GitHub Integration
- Continuous Integration (CI)
- Deploy Job
- Scheduled Job Execution
- Snowflake Deployment

## Key Features

- End-to-End ELT Pipeline
- Layered dbt Architecture
- Star Schema Data Modeling
- Incremental Models with Merge Strategy
- SCD Type 2 Snapshots
- Data Quality Testing
- Snowflake Data Warehouse
- dbt Cloud CI/CD
- GitHub Version Control

## Future Enhancements

- Apache Airflow Orchestration
- CDC-based Data Ingestion
- Kafka Streaming Integration
- Power BI Dashboard
- Data Observability with Elementary
- Automated Data Monitoring

## Key Learnings

Working on this project helped me get hands-on with:
- Analytics Engineering / Data Engineering best practices
- Layered dbt project architecture
- Incremental model implementation
- SCD Type 2 snapshots
- Star Schema design
- Data quality testing
- CI/CD using dbt Cloud
- Git-based version control
- Snowflake data warehousing

---

## Author

**Vindeshwar Gautam**

**Skills:** SQL • dbt Core • dbt Cloud • Snowflake • Analytics Engineering / Data Engineering • Data Modeling • Git & GitHub

If you found this project useful, consider giving it a star!
