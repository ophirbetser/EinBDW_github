


usethis::edit_rstudio_snippets()



#------------------------------------------------------------------------------#
# script info and options ----
#### File Name:   ##########                 
#### Date:        2021-##-##                
#### Author:      Ophir Betser              
#### Author Mail: ophir.betser@gmail.com    
#### phone number: 053-4209480

# Description and work process
#
#
#


#------------------------------------------------------------------------------#  
# load packages and set environment ----
options(scipen=999) # Disables scientific notation          
options(digits=6)   # Limits the number of digits printed       
Sys.setlocale("LC_ALL", locale = "Hebrew")

if (!require("pacman")){                                  
    install.packages("pacman")}                            
pacman::p_load(
          pacman, 
          data.table,
          tidyverse,
          patchwork,
          visdat,
          shiny)

#------------------------------------------------------------------------------#
# script ----


#------------------------------------------------------------------------------#
# usethis ----
esquisse::esquisser(viewer = "browser")
usethis::edit_rstudio_snippets()

#------------------------------------------------------------------------------#
# clearing environment ----
p_unload(all)   # Clear packages                  
dev.off()       # Clear plots      
cat("\014")     # Clear console 
rm(list = ls()) # Clear environment                           
#.rs.restartR() # restart R studio                    

#------------------------------------------------------------------------------#


