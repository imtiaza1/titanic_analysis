# ===== DEMOGRAPHIC ANALYSIS SCRIPT =====
# Purpose: Answer "Who was on the Titanic?"
# Business Questions: What was the passenger composition?

# Load packages and data
library(dplyr)
titanic <- read.csv("data/processed/titanic_cleaned.csv")

# QUESTION 1: What was the gender distribution?
titanic %>% count(Sex) 
# YOUR CODE HERE: Count passengers by Sex, calculate percentages

# QUESTION 2: What was the class distribution?
# YOUR CODE HERE: Count passengers by Pclass, calculate percentages
# BONUS: Add readable class names (First Class, Second Class, Third Class)

# QUESTION 3: What was the age distribution?
# YOUR CODE HERE: Calculate mean, median, min, max age
# YOUR CODE HERE: Count passengers by AgeGroup, calculate percentages

# QUESTION 4: What were the family size patterns?
# YOUR CODE HERE: Count passengers by FamilyType, calculate percentages

# QUESTION 5: Which ports did passengers embark from?
# YOUR CODE HERE: Count passengers by Embarked, calculate percentages
# BONUS: Add readable port names (Cherbourg, Queenstown, Southampton)

# STEP 6: Save demographic report
# YOUR CODE HERE: Use sink() to write demographic_report.txt
# Include: total passengers, gender breakdown, class breakdown, age groups