library(glptools)
glp_load_packages(graphs = T)

setwd("COVID mask usage")

masks <- read_csv("mask-use-by-county.csv")

masks %<>%
  rename(FIPS = COUNTYFP) %>%
  pull_peers() %>%
  stl_merge(NEVER:ALWAYS) %>%
  mutate(
    p_5 = ((ALWAYS * 1 + FREQUENTLY * 0.8 + SOMETIMES* 0.5 + RARELY* 0.2 + NEVER* 0) ^ 5) * 100,
    ALWAYS = ALWAYS * 100,
    NEVER = NEVER * 100)

showtext_auto()
font_add("Museo Sans 300", "../../../MuseoSans_300.otf")
font_add("Museo Sans 300 Italic", "../../../MuseoSans_300_Italic.otf")

png("mask_usage_five.png", 3000, 2400, res = 200)
ranking(masks, p_5,
        plot_title = "Chance everyone is wearing a mask in five random encounters",
        subtitle_text = "Data collected between July 2 and July 14",
        caption_text = "Source: Greater Louisville Project
                        Data from the New York Times and Dynata")
dev.off()

png("mask_usage_always.png", 3000, 2400, res = 200)
ranking(masks, ALWAYS,
        plot_title = "Percent of people who say they always wear a mask in public around others",
        subtitle_text = "Data collected between July 2 and July 14",
        caption_text = "Source: Greater Louisville Project
                        Data from the New York Times and Dynata")
dev.off()

png("mask_usage_never.png", 3000, 2400, res = 200)
ranking(masks, NEVER,
        plot_title = "Percent of people who say they never wear a mask in public around others",
        subtitle_text = "Data collected between July 2 and July 14",
        order = "Ascending",
        caption_text = "Source: Greater Louisville Project
                        Data from the New York Times and Dynata")
dev.off()



  # "The chance all five people are wearing masks in five random encounters is calculated by assuming that
  # survey respondents who answered ‘Always’ were wearing masks all of the time,
  # those who answered ‘Frequently’ were wearing masks 80 percent of the time,
  # those who answered ‘Sometimes’ were wearing masks 50 percent of the time,
  # those who answered ‘Rarely’ were wearing masks 20 percent of the time,
  # and those who answered ‘Never’ were wearing masks none of the time."
