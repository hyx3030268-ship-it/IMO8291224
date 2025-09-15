library(ggplot2)
library(ggpubr)
library(ggpmisc)
library(ggExtra)
df<-read.csv("plant.csv")
p <- ggMarginal(
  ggplot(df, aes(rrn, ave, colour = group)) + 
    geom_point() +
    theme_bw() +
    theme(panel.grid = element_blank(),
          legend.position = "none") + # 可选：隐藏图例，因为边际图图例可能不匹配
    scale_colour_manual(values = c("#00B6FF","#FFD489")) +
    ylim(0, 0.08) +
    xlim(0, 15) +
    coord_fixed(ratio = 50),
  type = "density",
  groupColour = FALSE,  # 关键：关闭边际图的颜色分组
  groupFill = FALSE,    # 关键：关闭边际图的填充分组
  colour = "black",     # 为所有密度曲线统一设置颜色（例如黑色）
  fill = "grey80"       # 为所有密度曲线统一设置填充色（浅灰色）
)
p
ggsave('plant.pdf', p, width = 7, height = 5.4)