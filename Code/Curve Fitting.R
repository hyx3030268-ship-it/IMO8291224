library(ggplot2)
library(ggpubr)
library(ggpmisc)
library(ggExtra)

df <- read.csv("mergedcurve.txt", header = TRUE, sep = "\t", row.names = 1, check.names = FALSE)

head(df)

p1 <- ggplot(df, aes(x = rrn, y = percen)) + 
  # 首先添加误差棒（置于最底层）
  geom_errorbar(aes(ymin = percen - pers, ymax = percen + pers),
                size = 0.5, width = 0.9, colour = "#898989") +
  geom_errorbar(aes(xmin = rrn - rrns, xmax = rrn + rrns),
                size = 0.5, width = 0.06, colour = "#898989") +
  
  # 然后添加点和其他几何对象
  geom_point(aes(color = type, size = group,shape=group), size = 6.5) +
  scale_shape_manual(values = c(15, 16, 17, 18, 19, 20)) +
  scale_colour_manual(values = c("#F5829E", "#7BB541", "#00B6FF", "#FFD489")) +
  
  # 添加拟合曲线
  geom_smooth(
    method = "lm", 
    formula = y ~ poly(x, 2),  # 使用 raw = TRUE 使方程更易读
    se = TRUE, 
    color = "black"
  ) +
  
  # 添加统计标签
  stat_poly_eq(
    formula =  y ~ poly(x, 2),  # 必须与 geom_smooth() 的公式一致
    aes(label = paste(after_stat(rr.label), after_stat(p.value.label), sep = "~~~")),
    parse = TRUE,
    label.x = "left",
    label.y = "top",
    size = 5
  ) +
  
  # 主题设置
  theme_bw() +
  theme(
    plot.title = element_text(hjust = 0.5, size = 16), 
    plot.caption = element_text(size = 13), 
    axis.text = element_text(size = 17), 
    axis.title.x = element_text(size = 20),
    panel.grid = element_blank()
  )+  scale_y_continuous(breaks = seq(-0.5, 1.5, by = 0.25)) +  # 只设置刻度
  coord_cartesian(xlim = c(2.5, 12.5)) +
  scale_x_continuous(breaks = seq(2.5, 12.5, by = 2.5)) 
p1

ggsave('mergedcurve.pdf', p1, width = 5.6, height = 5)