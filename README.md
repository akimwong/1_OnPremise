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
Developed a Python-based dashboard that extracts information from multiple Excel files, each dedicated to track the progress of activities across main nodes. Each project is composed of elements that must meet a series of tasks to be marked as complete. The tool provides an intuitive and interactive visualization interface, built with CustomTkinter, to monitor progress, identify bottlenecks, and track milestone achievements across units.

This solution enables project managers to centralize and simplify data visualization for multiple activities, ensuring efficient decision-making and improving milestone tracking accuracy.

### 2. Excel Data Visualization for multiple SECONDARY nodes

<b>Short name:</b> SecondaryNodes_Visual </p>
<b>Role:</b> R Developer </p>
<b>Technologies:</b> R, Excel </p>
<b>Tags:</b> Data Visualization, Project Monitoring, Lollipop Graph </p>
<b>Key Tools:</b> R, Shiny, Microsoft Excel </p>
<b>Packaging/Distribution:</b> Inno Setup Compiler </p>
<b>Description:</b> 
Developed an interactive R Shiny dashboard to monitor hundreds of secondary nodes from a single Excel file. Unlike the project 1, this solution focuses on tracking multiple mini-projects within a single file, along with the execution tasks required to complete each one.

The Shiny app provides an accessible and dynamic interface for monitoring progress, analyzing milestone completion rates, and identifying areas of delay. This tool enhances visibility into the status of numerous small projects, enabling project managers to streamline monitoring processes, improve accountability, and support more effective resource allocation.




```
man -k
``` 

