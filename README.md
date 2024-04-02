# COVID19-project

@article{owidcoronavirus,
    author = {Edouard Mathieu and Hannah Ritchie and Lucas Rodés-Guirao and Cameron Appel and Charlie Giattino and Joe Hasell and Bobbie Macdonald and Saloni Dattani and Diana Beltekian and Esteban Ortiz-Ospina and Max Roser},
    title = {Coronavirus Pandemic (COVID-19)},
    journal = {Our World in Data},
    year = {2020},
    note = {https://ourworldindata.org/coronavirus}
}


# COVID-19 Data Exploration using SQL

This project involves analyzing COVID-19 data using SQL. Various SQL techniques such as joins, CTEs, temporary tables, window functions, aggregate functions, and creating views are utilized to explore different aspects of the data.

## Overview of SQL Queries:

### 1. Total Cases and Total Deaths Analysis:
- Analyzes total cases, total deaths, and calculates death rates for specific locations like Spain and Portugal.

### 2. Infection Rate Analysis:
- Examines total cases versus population to determine the percentage of the population infected with COVID-19 in specific countries.

### 3. Highest Infection Rate and Death Count Analysis:
- Identifies countries with the highest infection rates compared to their population and highest death counts per population.

### 4. Continent-Wise Analysis:
- Breaks down data by continent to analyze death counts and identify continents with the highest death counts.

### 5. Global COVID-19 Numbers:
- Presents global statistics including total cases, total deaths, and death percentages.

### 6. Vaccination Analysis:
- Analyzes the relationship between total population and vaccination data for Spain, including calculating the percentage of the population vaccinated over time.

### 7. Intermediate Results Handling:
- Uses CTEs and temporary tables to perform calculations and store intermediate results.

### 8. Creating Views:
- Creates a view to store data for later visualizations.

## Files:

- **covid_data_analysis.sql**: Contains SQL queries for exploring COVID-19 data.
- **README.md**: This file, providing an overview of the project and the SQL queries used.

## Requirements:
- SQL Server environment.
- Access to COVID-19 datasets (`CovidDeaths` and `CovidVaccinations` tables).

## How to Use:
1. Connect to a SQL Server environment.
2. Execute the SQL queries provided in `covid_data_analysis.sql`.
3. Review the results and analyze the insights gained from the data.

## License:
This project is licensed under the MIT License.

