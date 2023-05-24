# Music_Store_data_Analysis


This repository contains a data analysis project focused on exploring a music database. The project involves extracting valuable insights related to customer preferences, track popularity, and sales trends. The analysis was performed using SQL queries on the provided database.

Database Schema

The database schema consists of the following tables:

employee: Contains information about the employees, including their job titles.
invoice: Stores details of the invoices, such as the billing country and total amount.
customer: Holds customer information, including their names and IDs.
invoice_line: Contains data related to invoice line items, such as the track ID, unit price, and quantity.
track: Stores track details, including the track name, length, and genre.
genre: Holds information about the different music genres.
artist: Contains data about the artists, including their names and IDs.
album: Stores album information, including the artist ID and album ID.

Project Insights

The project focuses on extracting various insights from the music database using SQL queries. Some of the insights include:
1.	Finding the senior most employee based on job title.
2.	Identifying the countries with the highest number of invoices.
3.	Determining the top three values of total invoices.
4.	Identifying the city with the best customers based on the sum of invoice totals.
5.	Determining the best customer who has spent the most money.
6.	Finding the email, first name, and last name of Rock music listeners.
7.	Identifying the top 10 rock bands based on the total track count.
8.	Retrieving track names and lengths longer than the average song length.
9.	Calculating the amount spent by each customer on the top-selling artist.
10.	Determining the most popular music genre for each country.
11.	Finding the customer who has spent the most on music for each country.

Repository Structure

database_files.rar: Contain the Tables to create the database schema.

Music_Store_query.sql: Contains the SQL queries used to extract insights from the database.

README.md: The current README file providing an overview of the project and repository.
