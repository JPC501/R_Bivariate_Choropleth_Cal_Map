# Load the necessary libraries
library(sf)            # Library for handling geospatial data
library(biscale)       # Library for creating bivariate maps
library(ggplot2)       # Popular library for data visualization
library(cowplot)       # Library for combining multiple plots in ggplot2

# Load the geographic data (shapefile) and the CSV with additional data
nc <- st_read("/Users/alverjoanperezcuellar/Downloads/California_County_Boundaries.geojson")
csv_data <- read.csv("/Users/alverjoanperezcuellar/Downloads/Cal-u-Rates-for-map.csv")

# Clean the county names in both datasets (remove extra spaces)
nc$CountyName <- trimws(nc$CountyName)
csv_data$County <- trimws(csv_data$County)

# Merge the geographic data with the CSV data based on the CountyName and County columns
nc_merged <- merge(nc, csv_data, by.x = "CountyName", by.y = "County")

# Classify the bivariate variables (Unemployment Rate and Rate H.S. Diploma or Less)
nc_bivar <- bi_class(nc_merged, x = Unemployment.Rate, y = `Rate.H.S..Diploma.or.Less`, style = "quantile", dim = 3)

# Calculate the centroids (geometric centers) of the counties to place the labels
nc_merged$centroid <- st_centroid(nc_merged$geometry)

# Create the bivariate map, making it 30% wider and removing the subtitle
mapa_bivariante <- ggplot() +
    geom_sf(data = nc_bivar, aes(fill = bi_class), color = "white", size = 0.1) +  # Add the map layer with counties
    bi_scale_fill(pal = "DkBlue", dim = 3) +  # Apply the bivariate color scale
    geom_sf_text(data = nc_merged, aes(geometry = centroid, label = CountyName), size = 1.25) +  # Add the county names with smaller font size
    labs(
        title = "California H.S. Diploma or Less Rate vs Unemployment Rate"  # Map title
    ) +
    bi_theme() +  # Apply a clean theme specific to bivariate maps
    theme(legend.position = "none",  # Remove the default legend on the right
          plot.title = element_text(size = rel(0.6)),  # Reduce the title size by 40%
          axis.title.x = element_blank(),  # Remove X axis label
          axis.title.y = element_blank(),  # Remove Y axis label
          axis.text.x = element_blank(),   # Remove X axis text
          axis.text.y = element_blank(),   # Remove Y axis text
          axis.ticks = element_blank())    # Remove ticks from both axes

# Create the bivariate legend (legend box)
leyenda_bivariada <- bi_legend(pal = "DkBlue", dim = 3, 
                               xlab = "Unemployment Rate",  # Label for the X axis (Unemployment Rate)
                               ylab = "Grad H.S. or Less",  # Label for the Y axis (High School Graduation or Less)
                               size = 7.5)  # Adjust the size of the legend text

# Adjust the positioning to move the "legend box" 10% to the right and 10% up
final_plot <- ggdraw() +
    draw_plot(mapa_bivariante, 0, 0, 1, 1) +  # Place the main map
    draw_plot(leyenda_bivariada, 0.50, 0.65, 0.2, 0.2)  # Adjust the position of the legend box (10% right, 10% up)

# Render the final plot
print(final_plot)
