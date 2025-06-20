---
title: "Data Visualization - Mini-Project 1"
author: "Jeremy Gerardi `jgerardi0371@floridapoly.edu`"
output:
  html_document:
    df_print: paged
---

```{r setup, include = FALSE}
library(readr)
library(dplyr)
library(ggplot2)
library(scales)
```

```{r}
dataset <- read_csv("../data/Global_Cybersecurity_Threats_2015_2024.csv", show_col_types = FALSE)

head(dataset)
```

## First Summary and Visualization
```{r}
lossByYear <- dataset %>%
  group_by(Year) %>%
  summarize(total_loss = sum(`Financial Loss (in Million $)`, na.rm = TRUE))

lossByYear
```
```{r}
ggplot(lossByYear, aes(x = factor(Year), y=total_loss, group = 1)) +
  geom_line(color = "red", linewidth = 1.2) + 
  geom_point() + 
  labs(title = "Financial Loss by Year", x = "Year", y = "Loss in Million $") +
  scale_y_continuous(labels = dollar_format(prefix = "$")) + 
  theme_minimal()
```

## Second summary and Visualization
```{r}
attacks <- dataset %>%
  group_by(`Attack Type`) %>%
  summarize(count = n()) %>%
  arrange(desc(count))

attacks
```
```{r}
ggplot(head(attacks, 10), aes(x = reorder(`Attack Type`, count), y = count, fill = `Attack Type`)) + 
  geom_col(show.legend = FALSE) +
  coord_flip() + 
  labs(title = "Top 10 Most Common Cyber Attack Types", x = "Attack Type", y = "Number of Attacks") +
  theme_minimal() + 
  scale_fill_brewer(palette = "Set2")
```

## Third Summary and Visualization
```{r}
topVulnerabilities <- dataset %>%
  filter(!is.na(`Security Vulnerability Type`) & `Security Vulnerability Type` != "" & `Security Vulnerability Type` != "Unkown") %>%
  group_by(`Security Vulnerability Type`) %>%
  summarize(count = n()) %>%
  arrange(desc(count)) %>%
  mutate(percentage = count / sum(count) * 100,
         label = paste0(`Security Vulnerability Type`))

topVulnerabilities
```

```{r}
ggplot(topVulnerabilities, aes(x = 2, y = percentage, fill = `Security Vulnerability Type`)) +
  geom_bar(stat = "identity", width = 1, color = "white") +
  coord_polar("y", start = 0) +
  geom_text(aes(label = label),
            position = position_stack(vjust = 0.5),
            size = 3) +
  xlim(0.5, 2.5) +
  theme_void() +
  labs(title = "Top Security Vulnerabilities Exploited in Cyber Attacks") +
  theme(legend.position = "none")

```

## Report:
### *a) What were the original charts you planned to create for this assignments?*
I had initially planned to create visualizations with a line chart, a bar chart, and a pie or a donut chart. However, I didn't know exactly which parts of the dataset they should represent until further exploring the actual data more thoroughly, so upon review, I decided to focus on a line chart representing data over time (specifically financial losses), a bar chart for the most common types of cyber attacks, and a donut chart on the most exploited security vulnerabilities.

### *b) What story could you tell with your plots?*
The story I wanted to tell with my plots are the serious threat that cybersecurity incidents pose to organizations around the globe. The financial loss chart showcases the high cost of these attacks over the past decade. The bar chart shows which types of attacks are most common that organizations can face. The donut chart highlights the specific security vulnerabilities that are most frequently exploited. These charts are meant to show the importance of protecting against cybersecurity attacks and what vulnerabilities are needed to be focused on to ensure risk is limited, hopefully inspiring action to create better cybersecurity protocols to prevent these attacks.

### *c) How did you apply the principles of data visualizations and design for this assignment?*
I used a line chart to show trends over time, although the trend in financial losses seem to have remained stable over the past five years. I used the horizontal bar chart to ensure attack types with long names like MITM (man in the middle) are legible. I used a donut chart to clearly present proportions of the security vulnerabilities exploited, showing that these four presented in the dataset are all equally important and should all be of high importance. 
