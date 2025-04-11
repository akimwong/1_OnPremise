# Secondary Nodes Visualization Dashboard

## Overview
An interactive R Shiny dashboard for monitoring multiple secondary nodes from a single Excel file. This solution focuses on tracking mini-projects and their associated execution tasks, providing project managers with real-time progress visualization and analytics.

## Key Features

### Dashboard Components
1. **Dynamic Lollipop Chart Visualization**
   - Visual representation of project status across multiple dimensions
   - Color-coded status indicators (green = complete, yellow = in-progress, white = not started)
   - Percentage completion indicators for each task

2. **Comprehensive Filtering System**
   - Filter by release date
   - Filter by project status (design, ongoing, progress, ready, etc.)
   - Sort by multiple criteria (BTP, STATUS, RELEASE DATE, NUMBER CRC, TEAM)

3. **Metrics Dashboard**
   - General state by release date visualization
   - Projects by release date timeline
   - Weekly completion rate tracking

4. **Data Management**
   - Automatic data refresh capability
   - Caching system for improved performance
   - Error handling for data loading

## Technical Specifications

### Technologies Used
- **Primary Language**: R
- **Framework**: Shiny
- **Data Source**: Microsoft Excel
- **Packaging**: Inno Setup Compiler

### Key R Packages
- shiny
- ggplot2
- dplyr
- tidyr
- lubridate
- shinyWidgets
- memoise (for caching)
- openxlsx (Excel handling)

## Screenshots

### Lollipop Chart View
![Lollipop Chart](screenshots/lollipop_chart.png)
- Displays project status across multiple dimensions
- Color-coded completion indicators
- Comprehensive project metadata display

### Metrics Dashboard
![Metrics View](screenshots/metrics_view.png)
- Shows project completion trends
- Visualizes workload distribution
- Projects weekly completion rate

## Installation & Usage

### Requirements
- R (version 4.0 or higher)
- RStudio (recommended)
- Microsoft Excel (for data input)

### Setup Instructions
1. Clone this repository
2. Install required R packages: `install.packages(c("shiny", "ggplot2", "dplyr", "tidyr", "lubridate", "shinyWidgets", "memoise", "openxlsx"))`
3. Place your Excel data file in the project directory (named "dashboard.xlsx")
4. Run the application: `shiny::runApp()`

### Data Format Requirements
The Excel file must contain two sheets:
1. **ONGOING**: Active projects
2. **FINISHED**: Completed projects

Required columns:
- ProjectCode
- Province
- Release Date
- Circuit Type
- Relocation Type
- Project Status
- Requisite_1
- Requisite_2
- Building Code
- Design Date
- Migration_Code
- Equipment
- Job Date
- Contractor
- JOB_CODE
- JOB STATUS
- App_Date
- Hour
- Current Stock

## Benefits

### For Project Managers
- **Real-time Monitoring**: Track hundreds of secondary nodes simultaneously
- **Progress Analysis**: Visualize milestone completion rates
- **Delay Identification**: Quickly spot bottlenecks in project execution
- **Resource Allocation**: Make data-driven decisions for team assignments

### For Teams
- **Clear Visibility**: Understand project status at a glance
- **Accountability**: Transparent tracking of responsibilities
- **Efficiency**: Reduce time spent on status reporting

## Performance Features
- **Caching System**: Memoization of expensive operations
- **Selective Data Loading**: Only required columns are loaded
- **Dynamic UI**: Adjusts to dataset size
- **Error Handling**: Graceful degradation when data is missing

## License
This project is licensed under the MIT License - see the LICENSE file for details.

## Contact
For questions or support, please contact the project maintainer.
