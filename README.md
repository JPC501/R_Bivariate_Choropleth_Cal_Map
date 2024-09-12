# Bivariate Map of California: H.S. Diploma or Less vs. Unemployment Rate

This project generates a **bivariate map** of California counties, visualizing two key variables: **Unemployment Rate** and **High School Diploma or Less**. The map uses a bivariate color scale to display the relationship between these two variables for each county.

## Requirements

Before you begin, ensure you have the following:

1. **R** installed on your system.
2. **RStudio**, an IDE for R, to run and manage the code.
3. A **GeoJSON file** containing the geographic boundaries (California counties).
4. A **CSV file** containing unemployment rate and high school diploma data for each county.

## Installation and Setup

### 1. Install R

Download **R** from the [CRAN R Project](https://cran.r-project.org/).

- Follow the instructions for your operating system (Windows, macOS, or Linux).

### 2. Install RStudio

Download **RStudio** from the [RStudio website](https://www.rstudio.com/products/rstudio/download/).

Follow the installation steps based on your OS.

### 3. Install Required R Packages

In RStudio, install the following necessary packages:

```r
install.packages("sf")        # For handling geospatial data
install.packages("biscale")   # For creating bivariate maps
install.packages("ggplot2")   # Popular for data visualization
install.packages("cowplot")   # For combining multiple plots in ggplot2

### 4. Required Files

You will need two files for this project:

- A **GeoJSON** file: `California_County_Boundaries.geojson` (contains geographic data for California counties).
- A **CSV** file: `Cal-u-Rates-for-map.csv` (contains data for unemployment rate and high school diploma or less percentages).

Make sure both files are in the correct format before proceeding.

### 5. Running the Project

Follow these steps to run the code in RStudio:

#### Load the Data:
Upload your **GeoJSON** and **CSV** files into RStudio or place them in the same directory.

#### Edit File Paths:

In the script, update the file paths for the `California_County_Boundaries.geojson` and `Cal-u-Rates-for-map.csv` files to match your system's file structure.

#### Run the Script:

Run the full script to generate the bivariate map. It will load the data, clean the county names, merge the data, classify variables, and create a map with county labels.

### Example of CSV Structure

The CSV should contain at least these three columns:

| County   | Unemployment-Rate | Rate H.S. Diploma or Less |
|----------|-------------------|---------------------------|
| Alameda  | 5.1               | 49.4                      |
| Alpine   | 7.7               | 64.5                      |
| Amador   | 5.5               | 69.7                      |

Ensure that the CSV file columns match the exact names used in the script.

### GeoJSON File

Your **GeoJSON** file should contain the geographic boundaries of the counties in California. This is what the map will use to draw the county shapes. Ensure that the county names in this file match those in your CSV file for a successful merge.

### Credits

This project was inspired by the `biscale` package tutorial available at the [CRAN R Project website](https://cran.r-project.org/web/packages/biscale/vignettes/biscale.html). All the bivariate map techniques in this project are based on the methods explained in that tutorial.
