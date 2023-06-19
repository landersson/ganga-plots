library(dsims)
library(ggpubr)
library(ggplot2)

study.region2 <- readRDS("../studyregion_RDSfiles/study.region_simp.rds")
region <- make.region (region.name = "Study Region", units = "m", shape = study.region2)
eg.survey <- readRDS("../XXX.rds")

make_map_plot <- function(x, y) {

    sf.region <- y@region
    transects <- x@transect@samplers

    pop.df <- x@population@population
    pts <- sp::SpatialPoints(data.frame(x = pop.df$x, y = pop.df$y))
    pts.sf <- sf::st_as_sf(pts)
    distdata <- na.omit(x@dist.data)
    pts2 <- sp::SpatialPoints(data.frame(x = distdata$x, y = distdata$y))
    detect.sf <- sf::st_as_sf(pts2)
    sf::st_crs(detect.sf) <- sf::st_crs(sf.region)
    sf::st_crs(pts.sf) <- sf::st_crs(sf.region)

    #p <- ggplot() + theme_void() +
        #geom_sf(data = sf.region, color = "#60607040", fill="grey90", lwd = 0.5) +
        ##geom_sf(data = transects, mapping = aes(), colour = "blue", lwd=0.1) +
        #geom_sf(data = pts.sf, mapping = aes(), colour = "steelblue4", cex = 1.5) +
        #geom_sf(data = detect.sf, mapping = aes(), colour = "hotpink3", cex = 2.5)
    
    p <- ggplot() + theme_void() +
        geom_sf(data = sf.region, color = "#60607040", fill="grey90", lwd = 0.5) +
        #geom_sf(data = transects, mapping = aes(), colour = "blue", lwd=0.1) +
        geom_sf(data = pts.sf, mapping = aes(), colour = "#619CFF", cex = 1.5) +
        geom_sf(data = detect.sf, mapping = aes(), colour = "#F8766D", cex = 2.5)

    return(p)
}

make_histogram <- function(x, y) {

    distdata <- na.omit(x@dist.data)
    bins <- nclass.Sturges(distdata$distance) * 1
    breaks <- seq(0, max(na.omit(distdata$distance)), length = bins)
    p <- ggplot(data=distdata, aes(x = .data$distance)) +
        geom_histogram(breaks=breaks,
                       col="grey16",
                       #fill="lightblue4",
                       fill="white",
                       alpha = 1) +
        theme_classic() +
        geom_points() + 
        theme(aspect.ratio=0.5) +
        #coord_fixed(ratio=2) +
        #theme(axis.text=element_text(size=10),         # Size of axis numbering
              #plot.margin = margin(3,0.5,2,0,"cm"),
              #axis.title=element_text(size=12)) +      # Size of axis titles
        labs(x="Distance", y="Count")

    return(p)
}

theme_classic()
p1 <- make_map_plot(eg.survey, region)
p2 <- make_histogram(eg.survey, region)

p = ggarrange(p1, p2,
              widths = c(2.5,1),
              labels = c("(a)", "(b)"), 
              font.label = list(size = 10, color = "black"))
plot(p)
ggsave(file="map.svg", width=8, height=6)
