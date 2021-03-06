#install libraries-----
library(tidyverse)
library(here)
library(glue)
library(cowplot)
library(ggpubr)
library(png)
library(sysfonts)

sysfonts::font_add_google("Roboto Mono", "Roboto Mono")

#build ad-----
build_ad <- function(number = 1){
  #1.454545:1 ratio
  #https://s3.amazonaws.com/snwceomedia/dtc/98d41aff-2324-4461-b600-3f19d09000ef.original.pdf
  xmax <- 1920
  ymax <- 1320
  
  #title
  title1 <- "This ad was generated entirely using code."
  title2 <- "Want to learn how?"
  title3 <- stringr::str_wrap("Check out in-person and online, synchronous and asynchronous modules to learn coding, data science, machine learning, AI, ethics, privacy, cybersecurity and more.", width = 55)
  # title3 <- "Check out in-person and online\nsynchronous and asynchronous modules to\nlearn coding, data science, machine learning, AI, ethics, privacy, cybersecurity\nand more."
  str_length(title3)
  cct_url <- "computationalthinking.duke.edu"
  
  random_background <- sample(list.files(here::here("media"), 
                                         pattern = "background"), 1)
  background_slide <- png::readPNG(here::here("media", random_background))
  
  slide <- 
    ggplot() +
    background_image(background_slide) + #put slide background here
    scale_x_continuous(limits = c(0,xmax)) +
    scale_y_continuous(limits = c(0,ymax)) +
    annotate("text", 
             # x = xmax/2, y = ymax/1.66, #title1 for centered
             x = xmax/2.15, y = ymax/1.8, #title1 #1.66 for rightside
             label = title1, 
             hjust = 0.5, 
             color = "white", 
             size = 8, 
             family = "Roboto Mono") +
    annotate("text", 
             x = xmax/2, y = ymax/2.8, #title2
             label = title2, 
             hjust = 0.5, 
             color = "white", 
             size = 6, 
             fontface = "bold") +
    annotate("text", 
             x = xmax/2, y = ymax/6, #title3
             label = title3, 
             hjust = 0.5, 
             color = "white", 
             size = 6, 
             fontface = "bold") +
    annotate("text",
             x = xmax/2, y = ymax/100, #url
             label = cct_url,
             hjust = 0.5,
             color = "orange",
             size = 6,
             fontface = "bold") +
    theme_void() +
    NULL
  
  plot_complete <- 
    ggdraw() +
    draw_plot(slide) +
    draw_image(here::here("media", "cct_horizontal_reversed_2x.png"), #cct header
               x = 0, 
               y = 0.35, 
               hjust = 0, 
               vjust = 0, 
               scale = 0.9) +
    #side
    draw_image(here::here("media", "cct_github_qr.png"), #qr code
               x = 0.41,
               y = 0.087,
               hjust = 0,
               vjust = 0,
               scale = 0.11) +
    #centered
    # draw_image(here::here("media", "cct_github_qr.png"), #qr code
    #            x = 0, 
    #            y = -0.025, 
    #            hjust = 0, 
    #            vjust = 0, 
    #            scale = 0.15) +
    NULL
  
  #source(here::here("code", "png.R"))
  
  image_name <- glue::glue( "cct_ad{number}.jpg")
  image_path <- here::here("data", image_name)
  
  ggsave(filename = image_path, 
         plot = plot_complete, 
         device = "jpg",
         width = 10, 
         height = 6.875, 
         units = "in",
         dpi = 300)
  
  #add custom message
  message(glue::glue('Built ad {number} for mailer'))
  
  return(image_path)
}
# #build 1 ad
# build_ad()

#build 10 ads
# for (i in 1:10) {
#   build_ad(i)
# }
