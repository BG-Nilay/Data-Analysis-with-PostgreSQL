# PubChem Data Quality and Activity Analysis

## Overview

This project demonstrates SQL-based data quality analysis using PostgreSQL and data from a PubChem BioAssay record. It focuses on activity outcomes, IC50 measurements, missing values, and duplicate-record checks.

## Data Source

- **Database:** PubChem BioAssay
- **BioAssay ID:** AID 1000
- **Assay:** Screening for Inhibitors of the Mevalonate Pathway in Streptococcus pneumoniae - MK Secondary Assay
- **Data contributor listed by PubChem:** SRMLSC
- **Records analyzed:** 57

Source links:
- [PubChem AID 1000](https://pubchem.ncbi.nlm.nih.gov/bioassay/1000)
- [SRMLSC source page](https://pubchem.ncbi.nlm.nih.gov/source/SRMLSC)

## Analysis Scope

The project includes SQL queries for:
- Counting activity outcomes
- Checking missing values
- Identifying duplicate Substance IDs (SID) and Compound IDs (CID)
- Summarizing IC50 measurements
- Reviewing data completeness by column

## Tools

- PostgreSQL
- pgAdmin 4
- SQL
- Microsoft Excel

## Project Files

- `01_create_schema.sql` — creates the database schema.
- `02_create_table.sql` — defines the table structure.
- `03_data_validation.sql` — contains data quality checks and analysis queries.


## Notes and Limitations

This project concerns one specific bioassay. An Active classification does not, by itself, establish that a compound is an effective antibiotic or a safe medicine.

The IC50 unit and assay-specific interpretation should be verified against the original assay documentation before drawing biological conclusions.

## Data Provenance and Usage

The AID 1000 bioassay record is presented by PubChem as provided by its original depositor. The data source is listed as SRMLSC.
This repository contains SQL scripts and project documentation only. The original downloaded dataset and cleaned data file are not included.
Please refer to the original data source for applicable reuse and redistribution terms.