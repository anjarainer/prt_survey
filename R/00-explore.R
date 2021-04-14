library(tidyverse)
library(visdat)

incomplete_df <- read_csv("data/raw/incomplete_responses.csv")


# explore missings ----
vis_dat(incomplete_df)

visdat::vis_miss(incomplete_df)

# do something else ----

answer_levels <- c("Completely agree", "Agree", "Neither agree or disagree",
                   "Disagree", "Completely disagree", "I don't know")

q1_df <- incomplete_df %>% 
  select(starts_with("Q1[")) %>% 
  mutate(across(.fns = factor, levels = answer_levels))

  # alternative way to write the last line
  mutate(across(.fns = ~factor(.x, levels = answer_levels)))


# to analyse multiple variables at once, we need to "pivot" them into the "long"
# data format. See https://tidyr.tidyverse.org/articles/pivot.html#string-data-in-column-names
# (only read from the top up to the heading "Numeric data in column names")
q1_summary <- q1_df %>% 
  pivot_longer(everything(), names_to = "var", values_to = "value") %>% 
  count(var, value)


# then we can plot
q1_summary %>% 
  # make missing values explicit so they show up in the plot
  mutate(value = fct_explicit_na(value)) %>% 
  ggplot(aes(var, n, fill = value)) +
  geom_col() +
  coord_flip()

q1_summary %>% 
  # filter out NA, since they are meaningless here
  filter(!is.na(value)) %>% 
  ggplot(aes(var, n, fill = value)) +
  geom_col() +
  coord_flip()



