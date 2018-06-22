#Interactive Exploration: The impact of outlier on regression results
#An R Shiny - d3.js application.

# Downward Bias the $R^2$:

#Consider the outlier on the left side. It does not fit the **line** the rest of the data points create. 
#Click&Drag it on the right in the line with the other points and see what happens to the $R^2$.


# Upward Bias the $R^2$:

#Consider the outlier in the lower right hand corner. It does not fit the **circle** the rest of the data points create. 
#Click&Drag it on the right in the line with the other points and see what happens to the $R^2$.


# Final Remarks
#Credits to unknown: I remember seeing a similar show case in the field of psychology some time ago. I think it was
#pure java-script implementation. Unfortunately, I could not find it again. 

#runApp("C:/Users/d91115/Dropbox/Application/Shiny/Custom_Output_Bindings_Publish/d3_Drag_Regression/DownwardBias", launch.browser = TRUE)
library(shiny)
options(digits=2)
df <- data.frame(x = seq(20,150, length.out = 10) + rnorm(10)*8,
                 y = seq(20,150, length.out = 10) + rnorm(10)*8)
df$y[1] = df$y[1] + 80
#plot(df)
shinyServer( function(input, output, session) {

  output$mychart <- renderDragableChart({
    df
  }, r = 3, color = "purple")
  
  output$regression <- renderPrint({
    if(!is.null(input$JsData)){
      mat <- matrix(as.integer(input$JsData), ncol = 2, byrow = TRUE)
      summary(lm(mat[, 2] ~  mat[, 1]))
    }else{
      summary(lm(df$y ~  df$x))
    }
  })
})

# Check out how your R-squared and the significance of your estimates can heavily depend
# upon a single data point. 


# Note: The idea of the second chart was already published by somebody else. Unfortunately,
# I could not find the site anymore, so I decided it to reproduce it in d3 and R.