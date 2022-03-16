---
  title: "Crop Yield"
output: html_notebook
---
  
  # Import libraries
  ```{r, message=FALSE}
library(cobalt)
library(WeightIt)
library(lmtest)
library(sandwich)
```

# Task 1
```{r}
# Load file as dataframe
farm_df <- read.csv("farm.csv")
```

# Task 2
```{r}
# Inspect dataframe
head(farm_df)
```

# Task 3
```{r}
# Balance plot for the average age
bal.plot(
  x = cover_10 ~ age_avg,
  data = farm_df,
  var.name = "age_avg",
  colors = c("#E69F00", "#009E73")
)
```

# Task 4
```{r}
# Balance plot for geographic region
bal.plot(
  x = cover_10 ~ region,
  data = farm_df, 
  var.name = "region", 
  colors = c("#E69F00", "#009E73") 
)
```

# Task 5
```{r}
# Balance table to show SMD and variance ratio of between groups
bal.tab (
  cover_10 ~ region + total_avg + age_avg + experience_avg + insurance_avg + easement_p + conservation_till_avg + fertilizer_per_area,
  data = farm_df, 
  binary = "std", 
  disp.v.ratio = TRUE)
)
```

# Task 6
```{r}
# Calculate IPTW weights with initial propensity score model
farm_iptw <- weightit(
  cover_10 ~ region + total_avg + insurance_avg + fertilizer_per_area,
  data = farm_df,
  method = "ps",
  estimand = "ATE"
)
```

# Task 7
```{r}
# Love plot with threshold lines to show SMD balance before and after weighting
love.plot(
  farm_iptw, 
  binary = "std", 
  thresholds = c(m = 0.1), 
  colors = c("#E69F00", "#009E73") 
)
```

# Task 8
```{r}
# Re-calculate IPTW weights with updated propensity score model
farm_iptw2 <- weightit(
  cover_10 ~ region + total_avg + insurance_avg + age_avg + experience_avg + easement_p + conservation_till_avg,
  data = farm_df,
  method = "ps",
  estimand = "ATE"
)
```

# Task 9
```{r}
# Plot Love plot of SMDs with threshold lines to show balance before and after IPTW procedure
love.plot(
  farm_iptw2, 
  binary = "std", 
  thresholds = c(m = 0.1), 
  colors = c("#E69F00", "#009E73") 
)
```

# Task 10
```{r}
# Balance plot of propensity scores before and after weighting
bal.plot(
  x = farm_iptw2, 
  var.name = "prop.score", 
  which = "both", 
  colors = c("#E69F00", "#009E73") 
)
```

# Task 11
```{r}
# Fit outcome regression model

```

# Task 12
```{r}
# Estimate regression coefficients for weighted outcome model with robust standard errors

```

# Task 13

## Results Interpretation:


