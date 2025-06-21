---
title: "Data Visualization - Mini-Project 2"
author: "Jeremy Gerardi `jgerardi0371@floridapoly.edu`"
output:
  html_document:
    df_print: paged
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE, warning = FALSE, message = FALSE)
library(tidyverse)
library(lubridate)
library(plotly)
library(sf)
library(tmap)
library(broom)
library(htmlwidgets)
```

```{r}
births <- read_csv("C:/Users/jerem/Downloads/dataviz_mini-project_02/dataviz_mini-project_02/data/us_births_00_14.csv")
```

```{r}
annual_births <- births %>%
  group_by(year) %>%
  summarise(total_births = sum(births))

annual_births
```


# Interactive plot
```{r}
births <- births %>%
  mutate(day_of_week = factor(day_of_week,
                              levels = c("Sun", "Mon", "Tues", "Wed", 
                                         "Thurs", "Fri", "Sat")))

day_summary <- births %>%
  group_by(day_of_week) %>%
  summarise(mean_births = mean(births))

p1 <- ggplot(day_summary, aes(x = day_of_week, y = mean_births, fill = day_of_week)) +
  geom_col() +
  labs(title = "Average Births by Day of Week", y = "Average Births") +
  theme_minimal()

p1_int = ggplotly(p1)
p1_int
saveWidget(p1_int, file = "interactive_plot.html", selfcontained = TRUE)
```

# Spatial Visualization
```{r}
births_data <- read_csv("../data/us_births_2016_2021.csv")

state_summary <- births_data %>%
  group_by(State) %>%
  summarise(avg_births = mean(`Number of Births`, na.rm = TRUE))

states_sf <- st_read("../data/tl_2024_us_state/tl_2024_us_state.shp", quiet = TRUE)

states_sf <- states_sf %>%
  filter(!(NAME %in% c("Alaska", "Hawaii", "Puerto Rico", "Guam", "American Samoa", "United States Virgin Islands", "Commonwealth of the Northern Mariana Islands")))

states_merged <- left_join(states_sf, state_summary, by = c("NAME" = "State"))

tm_shape(states_merged) +
  tm_polygons("avg_births", title = "Avg Births by State", palette = "Purples", style = "quantile") +
  tm_layout(
    title = "Average Births by U.S. State (Using Real Data)",
    title.size = 1.2,
    title.position = c("center", "top"),
    inner.margins = c(0.1, 0.2, 0.2, 0.2),
    frame = FALSE,
    legend.outside = TRUE,
    asp = 0
  )
```


# Linear model
```{r}
monthly_births <- births %>%
  mutate(month_year = floor_date(date, "month")) %>%
  group_by(month_year) %>%
  summarise(total_births = sum(births))

model <- lm(total_births ~ month_year, data = monthly_births)

p2 <- ggplot(monthly_births, aes(x = month_year, y = total_births)) +
  geom_point(alpha = 0.4) +
  geom_smooth(method = "lm", se = TRUE, color = "red") +
  labs(title = "Monthly U.S. Births Trend (2000–2014)",
       x = "Year",
       y = "Total Births") +
  annotate("text", x = as.Date("2003-01-01"), y = 400000, label = "", color = "red", size = 4, hjust = 0) +
  theme_minimal()

p2
```

# Report
a. What were the original charts you planned to create for this assignment?

The original charts stayed mostly the same throughtout the process, however the spatial visualization was supposed to be a heatmap of different birth rates per states.

b. What story could you tell with your plots? What difficulties did you encounter while creating the visualizations? What additional approaches do you think can be use to explore the data you selected?

I found it strange to see that the weekends were particularly low for birth data and it made me curious as to why. The other days of the week are all relatively close to each other but the weekends take a steep drop off. I also found it interesting that the late 2000's spikesin comparison to the early 2000's and the early 2010's. In terms of difficulty, I was able to find a shapefile for this data, however I could not find anything geographical that was usable with the shapefile.

c. How did you apply the principles of data visualizations and design for this assignment?

In terms of the interactive plot, ensuring the colors popped and were easily identifiable was crucial, with appropraite labels and legends. Keeping a minimal theme was important as well just to make it look cleaner and simpler, being used in the interactive plot as well as the linear model. 