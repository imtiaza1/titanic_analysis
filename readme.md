# 🚢 Titanic Passenger Survival Analysis

## 📌 Overview

Analysis of RMS Titanic passenger data (1912) to understand survival patterns for a historical documentary project. Focus on **class, gender, age, and family size**.

------------------------------------------------------------------------

## 🎯 Key Questions

1.  Which passengers were most likely to survive?\
2.  Did money buy survival (class vs survival)?\
3.  Was there a "women and children first" policy?\
4.  Did age and family size affect survival?

------------------------------------------------------------------------

## 📊 Dataset

-   **Source:** Titanic dataset (`titanic` R package / Kaggle)\
-   **Size:** 891 passengers\
-   **Variables:** Age, Sex, Pclass, Fare, Family, Embarked, Survival

------------------------------------------------------------------------

## 📂 Structure
titanic_analysis/
├── data/ # raw & cleaned data
├── scripts/ # R scripts for cleaning, analysis, viz
├── outputs/ # plots & reports
├── README.md
└── titanic_analysis.Rproj

---

## 🛠️ Tools
- **R (v4.0+)**, **dplyr**, **ggplot2 / base R graphics**  
- **RStudio**, **Git**  

---

## 🚀 How to Run
```r
install.packages(c("dplyr", "titanic"))

# Run in order:
source("scripts/01_data_cleaning.R")
source("scripts/02_demographic_analysis.R")
source("scripts/03_survival_analysis.R")
source("scripts/04_visualization.R")

📊 Results → outputs/plots/

📝 Reports → outputs/reports/
