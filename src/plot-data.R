library(tidyverse)


data <- read_table(
  "data/global-temperature.txt",
  skip = 5,
  col_names = c("year", "tempr", "smoothed")
) %>%
  select(year, tempr)

data %>%
  ggplot(aes(x = year, y = tempr)) +
  geom_line(aes(color = "1", ), size = 0.75, show.legend = FALSE) +
  geom_point(
    color = "1",
    fill = "white",
    shape = 21,
    show.legend = TRUE,
    size = 1
  ) +
  theme_light() +
  scale_x_continuous(breaks = seq(1880, 2020, 20), expand = c(0, 0)) +
  scale_y_continuous(limits = c(-0.5, 1.5), expand = c(0, 0)) +
  scale_color_manual(
    name = NULL,
    breaks = c("1", "2"),
    values = c("gray", "black"),
    labels = c("Lowess smoothing", "Annual mean"),
    guide = guide_legend(override.aes = list(
      shape = 15,
      size = 5,
      color = c("black", "gray")
    ))
  ) +
  geom_smooth(
    aes(color = "2"),
    se = FALSE,
    span = 0.17,
    size = 1,
    show.legend = FALSE
  ) +
  theme(
    axis.ticks.x = element_blank(),
    axis.ticks.y = element_blank(),
    panel.grid.minor = element_blank(),
    plot.title.position = "plot",
    plot.title = element_text(
      color = "red",
      size = 12,
      face = "bold",
      margin = margin(10, 0, 10, 0, unit = "pt")
    ),
    plot.subtitle = element_text(margin = margin(0, 0, 30, 0, unit = "pt")),
    plot.caption = element_text(margin = margin(0, 30, 10, 0, unit = "pt")),
    legend.position = c(0.14, 0.87),
    legend.title = element_text(size = 0),
    legend.key.height = unit(2, "pt"),
    legend.key = element_rect(color = "grey"),
    legend.key.spacing.y = unit(2, "pt"),
    legend.margin = margin(0, 0, 1, 0),
    margin = margin(t = 0, l = 0)
  ) +
  labs(
    title = "GLOBAL LAND-OCEAN TEMPERATURE INDEX",
    subtitle = "Data source: NASA's Goddard Institute for Space Studies (GISS)",
    caption = "Credit: NASA/GISS",
    x = "YEAR",
    y = "Temperature Anomaly (ºC)"
  )

ggsave("figures/temperature_index_plot.png",
       width = 6,
       height = 4)

