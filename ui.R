library(shiny)
library(shinyjs)

# Define UI for application that draws a histogram
fluidPage(
  useShinyjs(),
  
  # Application title
  titlePanel("Metastases risk calculator for prostate cancer patients with unspecific bone uptakes."),
  
  HTML("<p>This is an online skeletal metastases risk score calculator for prostate cancer patients exhibiting [18F]PSMA-1007 bone focal uptakes.
    Risks are calculated as presented in the paper:</br>
    <i>Composite prediction score to interpret bone focal uptakes in hormone-sensitive
prostate cancer patients imaged with [18F]PSMA-1007 PET/CT...</i></br> ... </p>"
  ),
  
  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      h4("Androgen-deprivation therapy"),
      HTML("at the time of PET/CT"),
      selectInput(
        "ADT",
        "",
        choices = list("", 'No' = 0, 'Yes' = 1)
      ),
      HTML("<hr>
           <h4>Mean Hounsfield Units (HU<sub>mean</sub>)</h4>
           description, range, ..."),
      numericInput(
        "HUmean",
        "",
        # min = 0,
        # max = 400,
        step = 0.1,
        value = NA
      ),
      HTML("<hr>
      <h4>Maximum Standardized Uptake Values (SUV<sub>max</sub>)</h4>
           Level of metabolic activity within ... region on a PET scan, range ..., ..."),
      numericInput(
        "SUVmax", 
        "",
        # min = -1000,
        # max = 2000,
        step = 0.1,
        value = NA
      ),
      # div(style = "text-align: center;",
      #     actionButton(inputId = "run", label = "Compute", 
      #                  onclick = "location.href='#outText';")
      # )
    ),
    # Show a plot of the generated distribution
    mainPanel(htmlOutput("outText"))
  )
)
