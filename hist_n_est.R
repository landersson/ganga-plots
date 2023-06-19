library(ggplot2)

# Given a simulation object, this will return the data relevant to plot a histogram
get_histogram_data_from_sim <- function(sim) {
    total.row <- dim(sim@results$individuals$N)[1]
    model.count <- length(sim@ds.analysis@dfmodel)
    rep.index <- which(sim@results$Detection[1,"SuccessfulModels",1:sim@reps] == model.count)
    N.ind.ests <- sim@results$individuals$N[total.row, "Estimate", rep.index]

    return (N.ind.ests)
}

ggplot_histogram <- function(sim, N) {

    N.ind.ests = get_histogram_data_from_sim(sim)

    n<-unname(N.ind.ests)

    bw = max(n) / 18
    df<-data.frame(n)

    p <- ggplot(df, aes(x=n)) + 
        geom_histogram(#color="grey16", 
                       #fill="#51abcb",               # Histogram bar colors
                       color="black",
                       fill="white",
                       #fill="lightblue4",
                       binwidth=bw) +
        labs(y="Number of iterations", 
             x="Abundance (N) estimate") +
        #theme(axis.text=element_text(size=8),          # Size of axis numbering
              #axis.title=element_text(size=10)) +      # Size of axis titles
        theme_classic()
        #scale_x_continuous(breaks=breaks) +
        scale_y_continuous(breaks=seq(0,100,50))

     if (N > 1) {
        p <- p + geom_vline(xintercept=N,
                   #color='orchid3', 
                   color='blue', 
                   #size=0.6, 
                   size=1.0,
                   linetype="dashed")
     }

    return (p)
}

