# ===== SURVIVAL ANALYSIS SCRIPT =====
# Purpose: Answer key business questions about survival patterns
# Questions: Who survived? What factors mattered most?

# Load packages and data
library(dplyr)
titanic <- read.csv("data/processed/titanic_cleaned.csv")

# QUESTION: What was the overall survival rate?
# Calculate total passengers, survivors, survival percentage
overll_survival_rate<-titanic %>% 
  count(Survived, name = "count") %>% 
  mutate(
    perc = round(count / sum(count) * 100, 1),
    Survivors = case_when(
      Survived == 1 ~ "Survivor",
      Survived == 0 ~ "Non-Survivor"
    )
  ) %>% 
  select(Survivors, count, perc)
# sava file
write.csv(overll_survival_rate,
          "outputs/overll_survival_rate.csv", row.names = FALSE)

# BUSINESS QUESTION 1: "Did money buy survival?"----
# calculate survival rate for each class
survival_by_class <-titanic %>% 
  group_by(Pclass) %>% 
  summarise(
    total = n(),
    survived = sum(Survived),
    survival_rate = round(survived / total * 100, 1)
  ) %>% 
  arrange(Pclass) %>% 
  print()

write.csv(survival_by_class,
          "outputs/survival_by_class.CSV", row.names = FALSE)

# BUSINESS QUESTION 2: "Was there really 'women and children first'?"
survival_by_gender<-titanic %>% 
  group_by(Sex, AgeGroup) %>% 
  summarise(
    total = n(),
    survived = sum(Survived),
    survival_rate = round(survived / total * 100, 1),
    .groups = "drop"
  ) %>% 
  print()
write.csv(survival_by_gender,
          "outputs/survial_by_gender.csv", row.names = FALSE)
# BUSINESS QUESTION 3: "How did family size affect survival?"
# calculate survival rate by family size
survival_by_familySize<-titanic %>% 
  group_by(FamilySize) %>% 
  summarise(
    total=n(),
    survived=sum(Survived),
    survival_rate=round(survived/total*100,1)
  ) %>% 
  print()
write.csv(survival_by_familySize,
          "outputs/survial_by_familySize.csv", row.names = FALSE)
# BUSINESS QUESTION 4: "Which combination was most deadly/safe?"
# Group by Pclass AND Sex together, calculate survival rates
titanic %>% 
  group_by(Pclass,Sex) %>% 
  summarise(
    total=n(),
    survived=sum(Survived),
    survival_rate=round(survived/total*100,1),
    .groups = "drop"
  ) %>% 
  arrange(desc(survival_rate))
# QUESTION: What about embarkation port - did that matter?
# calculate survival rate by port
survival_by_port<-titanic %>% 
  group_by(Embarked) %>% 
  summarise(
    total=n(),
    survived=sum(Survived),
    survival_rate=round(survived/total*100,1)
  )
write.csv(survival_by_port,
          "outputs/survial_by_port.csv", row.names = FALSE)

# STEP: Create executive summary
sink("outputs/reports/executive_summary.txt")

cat("EXECUTIVE SUMMARY - TITANIC SURVIVAL ANALYSIS\n")
cat("============================================\n\n")

# Overall survival rate
overll_survival_rate

cat("Overall Survival Rate:\n")
print(overll_survival_rate)

# Survival by Class
survival_by_class 

cat("Survival by Passenger Class:\n")
print(survival_by_class)
cat("\n")


# Survival by Gender
survival_by_gender

cat("Survival by Gender:\n")
print(survival_by_gender)
cat("\n")


# Survival by Age Group
survival_by_familySize

cat("Survival by familySize Group:\n")
print(survival_by_familySize)
cat("\n")
cat("Key Insights:\n")
cat(" - First class passengers had much higher survival rates.\n")
cat(" - Women survived at far higher rates than men.\n")
cat(" - Children had better survival chances than adults/elderly.\n")
cat(" - Solo travelers often had lower survival compared to small families.\n")

sink()


