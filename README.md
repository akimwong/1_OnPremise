## Overview
In the context of project management, <b>Excel is not a static document, it is a living entity that evolves over time.</p></b>

It grows as new data is added by multiple contributors, and the information entered today often triggers actions or dependencies that unfold in the future. Some data takes time to arrive, and its delayed entry can create bottlenecks or slow down progress in other areas.</p>

The first 6 projects in this repository contain code used to:</p>
I. Visualize information in a graphical way directly from one or more Excel spreadsheets.<br>
II. Validate, extract, and load Excel data into a MongoDB, with timestamps and record history.<br>
III. Perform actions or analyses using the information stored in the database.<br>

## Projects

### 1. Excel Data Visualization for MAIN nodes

<b>Short name:</b> MainNodes_Visual </p>
<b>Role:</b> Python Developer </p>
<b>Technologies:</b> Python, Excel </p>
<b>Tags:</b> Data Visualization, Project Monitoring, Heatmap Graph </p>
<b>Key Tools:</b> Python, CustomTkinter, Microsoft Excel </p>
<b>Packaging/Distribution:</b> pyinstaller </p>
<b>Description:</b> 
Developed a Python dashboard that aggregates data from multiple Excel files and translates complex task metrics into clear, actionable insights. Its intuitive CustomTkinter interface spotlights progress and bottlenecks while tracking milestone achievements, empowering project managers to centralize information and make fast, informed decisions.

### 2. Excel Data Visualization for multiple SECONDARY nodes

<b>Short name:</b> [SecondaryNodes_Visual](/projects/2_SecondaryNodes_Visual) </p>
<b>Role:</b> R Developer </p>
<b>Technologies:</b> R, Excel </p>
<b>Tags:</b> Data Visualization, Project Monitoring, Lollipop Graph </p>
<b>Key Tools:</b> R, Shiny, Microsoft Excel </p>
<b>Packaging/Distribution:</b> Inno Setup Compiler </p>
<b>Description:</b> 
Developed an interactive R Shiny dashboard that consolidates hundreds of secondary node projects from one Excel file, turning complex task data into clear visual insights. By presenting mini-project progress and execution details in a dynamic interface, the app <b>enables project managers to rapidly identify boost accountability, and allocate resources more effectively</b>.

### 3. Excel to MongoDB Data Pipeline

<b>Short name:</b> Excel_Pipeline </p>
<b>Role:</b> Data Engineer </p>
<b>Technologies:</b> R, MongoDB, Excel </p>
<b>Tags:</b> Data Extraction, NoSQL Database </p>
<b>Key Tools:</b> Jupyter Notebooks-R, MongoDB Compass, Microsoft Excel </p>
<b>Description:</b> Developed an R-based pipeline that extracts data from a large collaborative Excel file (70 columns × 2700 rows for 350 mini projects) and loads it into a structured MongoDB database. By <b>implementing an automated tracking system that logs cell values with timestamps</b> from 11 concurrent users, the solution maintains a full audit trail and ensures data integrity. This robust foundation enables real-time tracking, historical analysis, and automated notifications—empowering data-driven decisions and streamlined team collaboration.

### 4. Automated Email Generation

<b>Short name:</b> Email_Merge </p>
<b>Role:</b> Data Automation Developer </p>
<b>Technologies:</b> R, Python, Excel </p>
<b>Tags:</b> Data Processing, Email Automation, Template Generation </p>
<b>Key Tools:</b> Jupyter Notebooks-R, RStudio, VStudio Code, Microsoft Excel </p>
<b>Description:</b> Developed parallel implementations in Python and R to <b>automate the generation of personalized Outlook email templates from structured data</b>. By dynamically merging template structures with recipient information, the system streamlines mass communication while retaining personalization. A built-in manual verification step ensures accuracy before dispatch, enhancing overall efficiency.

### 5. Excel Data Validation

<b>Short name:</b> Data_Validation </p>
<b>Role:</b> Data Automation Developer </p>
<b>Technologies:</b> R, Python, Excel </p>
<b>Tags:</b> Data Validation, Data Extraction, Automated Reporting </p>
<b>Key Tools:</b> Jupyter Notebooks-R, RStudio, VStudio Code, Microsoft Excel </p>
<b>Description:</b> Developed parallel Python and R solutions that <b>validate production Excel data by comparing its structure and content to a reference file</b>. This automated check ensures column names and key values remain unchanged before proceeding to data extraction. By <b>guaranteeing reliable data feeds into downstream processes</b>, the system minimizes errors and boosts reporting accuracy.


```
man -k
``` 

