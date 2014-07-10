library(shiny)

shinyUI(fluidPage(
     titlePanel("Fertility in 19th century Switzerland"),
     div("The 'swiss' data set in R contains information about  47 French-speaking provinces in Switzerland 
           in the late 1880's, a time of demographic transition for that country. If you would like more information about the data set, you can see ", 
            span(a("this R documentation page,",
                   href = "http://stat.ethz.ch/R-manual/R-patched/library/datasets/html/swiss.html", target="_blank")),
        "but this app is self-contained and does not require familiarity with that page."),
        br(),    
        span("Use 
           the "), strong("dropdown menu"), span("below to plot a standardized measure of fertility against
           one of four socioeconomic indicators for the various provinces.  A regression
           line is included with each plot in order to give a basic indication of the relationship between the variables."),
     br(),br(),
                 
     span("At this time in Swiss history provinces were strongly polarized along religious
           lines, with 35 of the 47 provinces in the sample being either at least 90% Catholic 
            or 90% Protestant.  You can use the "), strong("checkboxes"), span("below the dropdown menu to 
            include or exclude majority-Catholic or majority-Protestant provinces. (In particular this will compute a new regression line.)"), 
     br(),br(),p("Data 
            points in the plot are colored on a sliding scale according to the religious
            composition of the province, with orange indicating a large Protestant majority 
            and green a large Catholic majority."),
     sidebarLayout(
     sidebarPanel(
         selectInput("dropdown", label=strong("Choose a socioeconomic indicator:"),
                     choices = list("Agriculture"=1, "Education" = 2, 
                                    "Infant Mortality"=3, "Test scores"=4),selected=1),
         checkboxGroupInput("religions",label=strong("Include provinces that were:"),choices = list(">50% Catholic"=1, 
                                                                         ">50% Protestant"=2), selected=c(1,2)
         )),
     mainPanel(
         
         
         plotOutput('myPlot')
     )
    )
)
)
