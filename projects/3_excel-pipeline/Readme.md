### Excel to MongoDB Data Pipeline

<b>Short name:</b> Excel_Pipeline </p>
<b>Role:</b> Data Engineer </p>
<b>Technologies:</b> R, MongoDB, Excel </p>
<b>Tags:</b> Data Extraction, NoSQL Database </p>
<b>Key Tools:</b> Jupyter Notebooks-R, RStudio, MongoDB Compass, Microsoft Excel </p>
<b>Description:</b> Developed a R script that extracts information from a large collaborative Excel file (around 70 columns × 2700 rows, to manage approximately 350 mini projects) and loads it into a structured MongoDB database. <b>The solution implements a tracking system that captures cell values with timestamps and monitors changes from approximately 11 concurrent users.</b> This approach maintains a complete historical record of modifications, enabling comprehensive audit trails while ensuring data integrity.

This foundational script sets the groundwork for future implementations:
- Automated data extraction from Excel to MongoDB
- Historical tracking system for all data changes
- Real-time monitoring of process advancement
- Automated notifications for task dependencies
- Performance metrics for task completion times

#### EXAMPLE:
<b>[1. First upload of information]((first_upload.png))</b>


<b>Excel Collaborative Issues:</b>
- Structure: variable column names, column additions/deletions, and order changes, making it difficult to maintain consistent data mapping and processing
- Data Quality: mixed data types within columns, multiple date and number formats, numbers stored as text, and empty/whitespace cells affecting data integrity
- Control: lack of real-time validation, multiple users can input incorrect data, and no standardized format enforcement leading to inconsistent data entry

<b>SCRIPT Process Flow:</b>
1. Initialization: load libraries (readxl, openxlsx, mongolite, jsonlite) & read Excel
2. Data Type Conversion Functions: functions for date/numeric conversion & type detection
3. DataFrame Processing: apply type conversions to the entire DataFrame
4. MongoDB Connection: Connect to collections, fetch records & create lookups
5. Data Processing: Process rows/columns, check changes & prepare updates
6. Database Update: Execute batch updates & historical records
