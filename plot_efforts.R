
library(ggplot2)
library(ggpubr)

source('hist_n_est.R')

double_effort <- readRDS("simulation_output/sim_N150_2x_500reps.rds")
triple_effort <- readRDS("simulation_output/sim_N150_3x_500reps.rds")
fourtimes_effort <- readRDS("simulation_output/sim_N150_4x_500reps.rds")

p1 <- ggplot_histogram(double_effort, 150)
p2 <- ggplot_histogram(triple_effort, 150)
p3 <- ggplot_histogram(fourtimes_effort, 150)

p = ggarrange(p1, p2, p3, 
              labels = c("(a)", "(b)", "(c)"), 
              ncol=3,
              font.label = list(size = 10, color = "black"))

# save to Rplots.pdf
pdf("Rplots.pdf", width=10, heigh=4)
plot(p)
# save to svg file
ggsave(file="efforts.svg", plot=p) 
