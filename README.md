# Analytics Engineering Playground

Practice project focused on analytical data modeling, SQL transformations and reporting-oriented workflows in BigQuery.

The goal of the project is to explore how analytical datasets can be structured using layered transformations, fact/dimension modeling and basic data quality checks.

---

# Tech Stack

- BigQuery
- SQL
- GitHub

---

# Project Structure

The project follows a simple layered approach:

RAW → STAGING → MARTS

## Layers

### RAW
Initial source tables loaded into BigQuery.

### STAGING
Data cleaning and standardization layer.

Examples:
- column renaming
- filtering invalid rows
- basic preprocessing

### MARTS
Analytical layer with fact and dimension tables used for reporting and aggregation.

Implemented:
- fact_trips
- dim_company
- company_daily_metrics

---

# Implemented Features

## SQL Transformations
- data cleaning
- aggregation queries
- joins
- analytical calculations

## Data Modeling
- fact and dimension tables
- star schema principles
- reporting-oriented structure

## Analytical Marts
Examples:
- company-level daily metrics
- revenue aggregation
- average check calculations

## Data Quality Checks
Basic SQL-based validation checks:
- NULL checks
- uniqueness checks
- logging validation results

---

# Example Workflow

1. Load raw taxi trip dataset
2. Build staging layer
3. Create fact and dimension tables
4. Generate analytical marts
5. Run data quality checks
6. Use resulting tables for reporting and dashboards

---

# What I Practiced

- working with BigQuery datasets
- SQL-based transformations
- layered data structure
- analytical data modeling
- aggregation logic
- basic data quality validation

---

# Planned Improvements

- dbt integration
- automated testing
- orchestration experiments
- additional marts and metrics

---

# Repository Purpose

This repository is part of my learning process in analytics engineering and modern analytical workflows.
