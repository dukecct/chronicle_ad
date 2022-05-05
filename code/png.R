#this script saves the image as a png for the README file
image_name <- glue::glue( "cct_ad.png")
image_path <- here::here("data", image_name)

ggsave(filename = image_path, 
       plot = plot_complete, 
       device = "png", 
       width = 10, 
       height = 6.875, 
       units = "in",
       dpi = "retina")