# ===== TITANIC DATA CLEANING SCRIPT =====
# Purpose: Clean and prepare Titanic dataset for analysis
# Questions: What does our data look like? What needs to be fixed?

# Load required packages
library(dplyr)

# STEP 1: Load the data
# using CSV file
titanic_raw <- read.csv("data/raw/train.csv")

# STEP 2: Initial data exploration
print("=== INITIAL DATA OVERVIEW ===")
str(titanic_raw)
summary(titanic_raw)
head(titanic_raw)

# STEP 3: Check for missing values
print("=== MISSING VALUES CHECK ===")
missing_data <- colSums(is.na(titanic_raw))
print(missing_data)

# STEP 4: Data cleaning and new variables
titanic_clean <- titanic_raw %>%
  # Remove unnecessary columns if they exist
  select(-c(PassengerId, Name, Ticket)) %>%
  
  # Handle missing Age values (replace with median)
  mutate(Age = ifelse(is.na(Age), median(Age, na.rm = TRUE), Age)) %>%
  
  # Handle missing Embarked values (replace with most common)
  mutate(Embarked = ifelse(is.na(Embarked) | Embarked == "", "S", Embarked)) %>%
  
  # Create age groups
  mutate(AgeGroup = case_when(
    Age < 16 ~ "Child",
    Age < 60 ~ "Adult", 
    TRUE ~ "Elderly"
  )) %>%
  
  # Create family size variable
  mutate(FamilySize = SibSp + Parch + 1) %>%
  
  # Create family type categories
  mutate(FamilyType = case_when(
    FamilySize == 1 ~ "Solo",
    FamilySize <= 4 ~ "Small Family",
    TRUE ~ "Large Family"
  )) %>%
  
  # Create fare groups
  mutate(FareGroup = case_when(
    Fare < 10 ~ "Low",
    Fare < 30 ~ "Medium",
    TRUE ~ "High"
  ))

# STEP 5: Save cleaned data
write.csv(titanic_clean, "data/processed/titanic_cleaned.csv", row.names = FALSE)

# STEP 6: Final data summary
print("=== CLEANED DATA SUMMARY ===")
str(titanic_clean)
print("Data cleaning completed! Check data/processed/ folder.")
