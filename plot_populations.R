library(ggplot2)
library(ggpubr)

source('hist_n_est.R')

pop500 <- readRDS("simulation_output/sim_N500_110000.rds")
pop1000 <- readRDS("simulation_output/sim_N1000_110000.rds")
pop2000 <- readRDS("simulation_output/sim_N2000_110000.rds")

p1 <- ggplot_histogram(pop500, 500)
p2 <- ggplot_histogram(pop1000, 1000)
p3 <- ggplot_histogram(pop2000, 2000)

p = ggarrange(p1, p2, p3, 
              labels = c("(a)", "(b)", "(c)"), 
              ncol=3,
              font.label = list(size = 10, color = "black"))
# save to Rplots.pdf
pdf("Rplots.pdf", width=10, heigh=4)
plot(p)
# save to svg file
ggsave(file="populations.svg", plot=p) 
