library(shiny)
library(shinyjs)

# Define UI for application that draws a histogram
fluidPage(id = 'main',
          tags$style('#main {background-color: #fff;}'),
          
  useShinyjs(),
  
  HTML('<h1>Bone Uptake Metastatic Probability (BUMP) score</h1>
      <p>
       This is a free, accessible webpage offering the BUMP risk score calculator.
       The Bone Uptake Metastatic Probability (BUMP) score calculator generates
       the probability of bone metastasis by integrating clinical and imaging data. 
       It is designed for prostate cancer patients exhibiting [18F]PSMA-1007 bone 
       focal uptakes on PET/CT imaging. 
       The risk calculations are based on the methodology presented in the
       "Composite Prediction Score to Interpret Bone Focal Uptakes in 
       Hormone-Sensitive Prostate Cancer Patients Imaged with 
       [18F]PSMA-1007 PET/CT" paper. 
       The score achieved an AUC of 0.8656. 
       This AUC was validated through 10-fold internal cross-validation, 
       obtaining an AUC equal to 0.8707 (95% CI: 0.8326-0.9030).
       </p><br>'
  ),
  
  HTML("<style>
    .circle {
      width: 230px;
      height: 230px;
      border-radius: 50%;
      margin:0;
      display: flex;  /* Use flexbox for centering text */
      justify-content: center;  /* Center text horizontally */
      align-items: center;  /* Center text vertically */
    }
    </style>"),
  
  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(id = 'form', width = 5,
      h4("Androgen-deprivation therapy"),
      HTML("at the time of PET/CT"),
      selectInput(
        "ADT",
        "",
        choices = list("", 'No' = 0, 'Yes' = 1)
      ),
      
      HTML("<hr>
      <h4>Maximum Standardized Uptake Values (SUV<sub>max</sub>)</h4>
           Maximum Standardized Uptake Values (SUVmax) should be determined by
           placing a volume of interest (VOI) encompassing the target lesion."),
      numericInput(
        "SUVmax", 
        "",
        min = 0,
        max = 400,
        step = 0.1,
        value = NA
      ),
      
      HTML("<hr>
           <h4>Mean Hounsfield Units (HU<sub>mean</sub>)</h4>
           The point of maximum tracer uptake on PET images (assessed by 
           measuring the SUVmax) should be selected as the centre of a VOI, 
           drawn by the threshold method (45%SUVmax). This VOI should be used 
           on CT images to assess mean Hounsfield Units (HU) of the lesion."),
      numericInput(
        "HUmean",
        "",
        min = -1000,
        max = 2000,
        step = 0.1,
        value = NA
      ),
      
      # div(style = "text-align: center;",
      #     actionButton(inputId = "run", label = "Compute", 
      #                  onclick = "location.href='#outText';")
      # )
    ),
    
    # Show a plot of the generated distribution
    mainPanel(width = 7,

          htmlOutput("outText"),
          
          HTML(
            "</br>
               <p style = 'color: #666; text-align:center;'>
               <i>This model is provided exclusively for educational, training,
               and informational purposes.<br>It is not intended to support medical
               decision-making or to provide medical or diagnostic services.</i>
               </p>"
          )
    
          )
        
 

  ),
  HTML('
      <footer style = "text-align: center; background-color: #fff; padding: 30px">
        <p>For information, refer to Matteo Bauckneht, MD, PhD, IRCCS Ospedale Policlinico San Martino and University of Genoa, Genova, Italy</p>
        <div>
          <div style="float: left;width: 45%; text-align: right">phone: <a href="tel:+390105554803">+39 010 555 4803</a></div>
          <div style="float: left;width: 5%;">~</div>
          <div style="float: left;width: 45%; text-align: left">email: <a href="mailto:matteo.bauckneht@unige.it?subject=BUMP risk score calculator">matteo.bauckneht@unige.it</a></div>
        </div>
      </footer>'),
)
