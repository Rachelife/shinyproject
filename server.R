library(shiny)
library(ggplot2)
library(dplyr)
library(babynames)
library(container)
library(Hmisc)
library(wordcloud2)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    output$text <- renderText({
        "The SSA baby names data comes from social security number (SSN) applications. SSA cards were first issued in 1936, but were only needed for people with an income. In 1986, the law changed effectively requiring all children to get an SSN at birth. The dataset contains baby names information from 1880 to 2017."
    })
    
    output$cloud <- renderWordcloud2({
        babywc <- babynames[babynames$year == 2017, -c(1,2,5)]
        babywc2 <- head(babywc,75)
        
        wordcloud2(babywc2)
    })
    
    output$plot1 <- renderPlot({
        yourname <- babynames[babynames$name == capitalize(input$yourname),]
        
        g1 <- ggplot(yourname, aes(x = year, y = n, colour = sex))+ 
            geom_point()+ 
            geom_line() +
            xlab('Year') +
            ylab('Number of applications') + 
            ggtitle("Number of applications with this name throughout years")+
            theme(plot.title = element_text(size = 20, face = "bold"))
        
        g1
    })
    
    output$plot2 <- renderPlot({
        yourname <- babynames[babynames$name == capitalize(input$yourname),]
        
        g2 <- ggplot(yourname, aes(x = year, y = prop, color = sex))+ 
            geom_point() + 
            geom_line() +
            xlab('Year') +
            ylab('Proportion') + 
            ggtitle("Proportions of applications with this name throughout years")+
            theme(plot.title = element_text(size = 20, face = "bold"))
        
        g2
    })
    
    output$table <- renderTable({
        
        # Show entire table when no state is selected by user 
        if(is.null(input$year)){return(babynames)}
        
        # Filter the data for different states selected by user input
        data_year0 <- babynames[babynames$year == input$year,]
        data <- data_year0[data_year0$sex == input$sex,]
        colnames(data) <- c("Year", "Sex", "Name", "Amount", "Proportion")
        
        # Return table
        return(head(data,20))
    })
    

})
