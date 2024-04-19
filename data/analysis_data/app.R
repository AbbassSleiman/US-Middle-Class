# Load necessary libraries
library(shiny)
library(ggplot2)
library(here)
library(tidyverse)

incarceration_data <- read_csv(here("data/analysis_data/incarceration_data.csv"))

incarceration_data <- incarceration_data |>
  mutate(education_category = factor(education_category))

# Define UI
ui <- fluidPage(
  titlePanel("Incarceration Rate Analysis"),
  sidebarLayout(
    sidebarPanel(
      selectInput("metric", "Choose a metric:",
                  choices = c("Violent Crime Rate", "Unemployment Rate", "Poverty Rate", "Educational Ranking Category")),
      conditionalPanel(
        condition = "input.metric == 'Educational Ranking Category'",
        selectInput("categories", "Choose educational ranking categories to highlight:",
                    choices = c("1-19", "20-34", "35-52", "53-71", "72-92", "93-110", 
                                "111-125", "126-147", "148-175", "176-198"),
                    multiple = TRUE)
      )
    ),
    mainPanel(
      plotOutput("plot")
    )
  )
)

# Define server logic
server <- function(input, output) {
  output$plot <- renderPlot({
    # Generate plot based on user selections
    if (input$metric == "Violent Crime Rate") {
      # Generate plot for violent crime rate
      ggplot(incarceration_data, aes(x = violent_crime_rate, y = incarceration_rate)) +
        geom_point() +
        theme_classic() +
        labs(x = "Violent Crime Rate", y = "Incarceration Rate")
    } else if (input$metric == "Unemployment Rate") {
      # Generate plot for unemployment rate
      ggplot(incarceration_data, aes(x = unemployment_rate, y = incarceration_rate)) +
        geom_point() +
        theme_classic() +
        labs(x = "Unemployment Rate", y = "Incarceration Rate")
    } else if (input$metric == "Poverty Rate") {
      # Generate plot for poverty rate
      ggplot(incarceration_data, aes(x = poverty_rate, y = incarceration_rate)) +
        geom_point() +
        theme_classic() +
        labs(x = "Poverty Rate", y = "Incarceration Rate")
    } else if (input$metric == "Educational Ranking Category") {
      # Generate plot for educational ranking category
      selected_categories <- input$categories
      # Reorder the educational ranking categories
      incarceration_data$education_category <- factor(incarceration_data$education_category, 
                                                                levels = c("1-19", "20-34", "35-52", 
                                                                           "53-71", "72-92", "93-110", 
                                                                           "111-125", "126-147", "148-175", 
                                                                           "176-198"))
      # Filter data based on selected categories
      filtered_data <- subset(incarceration_data, education_category %in% selected_categories)
      ggplot(filtered_data, aes(x = education_category, y = incarceration_rate, fill = education_category)) +
        geom_boxplot(outlier.shape = 21, outlier.size = 1.5, outlier.stroke = 0.5) +
        theme_classic() +
        labs(x = "Educational Ranking Category", y = "Incarceration Rate")
    }
  })
}

# Run the application
shinyApp(ui = ui, server = server)
