# ===== DEMOGRAPHIC ANALYSIS SCRIPT =====
# Purpose: Answer "Who was on the Titanic?"
# Business Questions: What was the passenger composition?

# Load packages and data
library(dplyr)
titanic <- read.csv("data/processed/titanic_cleaned.csv")

# QUESTION 1: What was the gender distribution?
titanic %>% count(Sex) %>% 
  mutate(percentage=n/sum(n)*100) %>% 
           print()
# QUESTION 2: What was the class distribution?
# YOUR CODE HERE: Count passengers by Pclass, calculate percentages
# BONUS: Add readable class names (First Class, Second Class, Third Class)
titanic %>% 
  count(Pclass,name = "count") %>% 
  mutate(perc=round(count/sum(count)*100,1),
  Class=case_when(
    Pclass==1~"first class",
    Pclass==2~"second class",
    Pclass==3~"third class"
  )) %>% 
  select(Class,count,perc) %>% 
    print()

# QUESTION 3: What was the age distribution?
#  Calculate mean, median, min, max age
titanic %>% 
  group_by(AgeGroup) %>% 
  summarise(avg_age=mean(Age),
            min_age=min(Age),
            max_age=max(Age),
            median_age = median(Age),
            ) %>% View()
#  Count passengers by AgeGroup, calculate percentages
titanic %>% 
  count(AgeGroup,name = "count") %>% 
  mutate(perc=round(count/sum(count)*100,1),
         Class=case_when(
           AgeGroup=="Adult"~"Adult",
           AgeGroup=="Child"~"Child",
           AgeGroup=="Elderly"~"Elderly"
         )) %>% 
  select(Class,count,perc)
# QUESTION 4: What were the family size patterns?
#  Count passengers by FamilyType, calculate percentages
titanic %>% 
  count(FamilyType, name = "count") %>% 
  mutate(perc = round(count / sum(count) * 100, 1)) %>% 
  select(FamilyType, count, perc)

# QUESTION 5: Which ports did passengers embark from?----
#  Count passengers by Embarked, calculate percentages
titanic %>% 
  count(Embarked,name = 'count') %>% 
  mutate(perc=round(count/sum(count)*100,1),
         Place=case_when(
           Embarked == "C" ~ "Cherbourg (France)",
           Embarked == "Q" ~ "Queenstown (Ireland)",
           Embarked == "S" ~ "Southampton (England)"
         )) %>% 
  select(Place,count,perc)


# STEP 6: Save demographic report
sink("outputs/reports/demographic_report.txt")   # start writing to file

cat("=== Titanic Demographic Report ===\n\n")

# Total passengers
cat("Total Passengers:\n")
titanic %>% summarise(total = n()) %>% print()
cat("\n")

# Gender breakdown
cat("Gender Distribution:\n")
titanic %>% count(Sex) %>%
  mutate(perc = round(n / sum(n) * 100, 1)) %>%
  print()
cat("\n")

# Class breakdown
cat("Class Distribution:\n")
titanic %>% count(Pclass) %>%
  mutate(perc = round(n / sum(n) * 100, 1)) %>%
  print()
cat("\n")

# Age group breakdown (make sure you created AgeGroup before!)
cat("Age Group Distribution:\n")
titanic %>% count(AgeGroup,name = "count") %>%
  mutate(perc = round(count / sum(count) * 100, 1)) %>%
  print()
cat("\n")

sink()   # stop writing to file

