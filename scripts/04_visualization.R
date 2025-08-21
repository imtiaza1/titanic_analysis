# ===== VISUALIZATION SCRIPT =====
# Purpose: Create professional charts for documentary presentation
# Business Goal: Visual stories that are easy to understand

# Load packages
library(dplyr)
library(ggplot2)
library(scales)

# Load processed Titanic dataset
titanic <- read.csv("data/processed/titanic_cleaned.csv")

# Ensure output folder exists
dir.create("outputs/plots", recursive = TRUE, showWarnings = FALSE)

# -----------------------------
# CHART 1: Survival Rate by Class
# -----------------------------
titanic %>% 
  group_by(Pclass) %>% 
  summarise(survival_rate = mean(Survived, na.rm = TRUE)) %>% 
  ggplot(aes(x = factor(Pclass), y = survival_rate, fill = factor(Pclass))) +
  geom_col() +
  geom_text(aes(label = percent(survival_rate, accuracy = 0.1)),
            vjust = -0.5, size = 4) +
  scale_y_continuous(labels = percent) +
  labs(
    title = "Survival Rate by Class",
    x = "Passenger Class",
    y = "Survival Rate (%)",
    fill = "Class"
  ) +
  theme_minimal()

ggsave("outputs/plots/Survival_By_Class.png", width = 7, height = 5, dpi = 300)

# -----------------------------
# CHART 2: Gender Survival Comparison
# -----------------------------
titanic %>% 
  group_by(Sex) %>% 
  summarise(survival_rate = mean(Survived, na.rm = TRUE)) %>% 
  ggplot(aes(x = Sex, y = survival_rate, fill = Sex)) +
  geom_col() +
  geom_text(aes(label = percent(survival_rate, accuracy = 0.1)),
            vjust = -0.5, size = 4) +
  scale_y_continuous(labels = percent) +
  labs(
    title = "Survival Rates by Gender (Women and Children First Policy)",
    x = "Gender",
    y = "Survival Rate (%)",
    fill = "Gender"
  ) +
  theme_minimal()

ggsave("outputs/plots/Gender_Survival.png", width = 7, height = 5, dpi = 300)

# -----------------------------
# CHART 3: Age Distribution
# -----------------------------
titanic %>% 
  ggplot(aes(x = Age, fill = Sex)) +
  geom_histogram(binwidth = 3, alpha = 0.6, position = "identity") +
  geom_vline(
    xintercept = mean(titanic$Age, na.rm = TRUE),
    color = "red", linetype = "dashed", linewidth = 1
  ) +
  labs(
    title = "Age Distribution of Passengers",
    x = "Age",
    y = "Count",
    fill = "Gender"
  ) +
  theme_minimal()

ggsave("outputs/plots/Age_Distribution.png", width = 7, height = 5, dpi = 300)

# -----------------------------
# CHART 4: Family Size Impact
# -----------------------------
titanic %>% 
  group_by(FamilyType) %>% 
  summarise(survival_rate = mean(Survived, na.rm = TRUE)) %>% 
  ggplot(aes(x = FamilyType, y = survival_rate, fill = FamilyType)) +
  geom_col() +
  geom_text(aes(label = percent(survival_rate, accuracy = 0.1)),
            vjust = -0.5, size = 4) +
  scale_y_continuous(labels = percent, limits = c(0, 1)) +
  labs(
    title = "Survival Rate by Family Type",
    x = "Family Type",
    y = "Survival Rate (%)",
    fill = "Family Type"
  ) +
  theme_minimal()

ggsave("outputs/plots/Survival_By_FamilyType.png", width = 7, height = 5, dpi = 300)

# -----------------------------
# CHART 5: Class vs Gender Interaction
# -----------------------------
titanic %>% 
  group_by(Pclass, Sex) %>% 
  summarise(survival_rate = mean(Survived, na.rm = TRUE)) %>% 
  ggplot(aes(x = factor(Pclass), y = survival_rate, fill = Sex)) +
  geom_col(position = "dodge") +
  geom_text(aes(label = percent(survival_rate, accuracy = 0.5)),
            position = position_dodge(width = 0.9),
            vjust = -0.5, size = 3.5) +
  scale_y_continuous(labels = percent, limits = c(0, 1)) +
  labs(
    title = "Survival Rates by Class and Gender",
    x = "Passenger Class",
    y = "Survival Rate (%)",
    fill = "Gender"
  ) +
  theme_minimal()

ggsave("outputs/plots/Survival_By_Class_Gender.png", width = 7, height = 5, dpi = 300)
