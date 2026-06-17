# Epiwave Visualisation Gadget

## Project Structure

## Project Structure

project/
│
├── Main.R                      # Main workflow script; runs the complete analysis and launches the gadget
│
├── raw/
│   ├── data.csv                # Example input dataset
│   ├── homepage.txt            # Home page content placeholder
│   └── diagram.png             # Project workflow diagram
│
├── www/
│   ├── style.css               # Custom styling for the gadget UI
│   └── script.js               # JavaScript utilities and notifications
│
└── R/
    ├── diagnose_model.R        # Model diagnostic utilities
    ├── download_plot.R         # Plot export/download functions
    ├── epiwaveVisualisationGadget.R  # Main Shiny gadget
    ├── extract_model_info.R    # Extract model outputs and metadata
    ├── fit_model.R             # Model fitting routines
    ├── plot_convergence.R      # MCMC convergence visualisations
    ├── plot_posterior_check.R  # Posterior predictive checks
    ├── plot_prior_check.R      # Prior predictive checks
    ├── prior_check.R           # Prior simulation utilities
    ├── summarise_greta.R       # Summary methods for greta models
    └── validate_model.R        # Input and model validation

## Setup

Run everything in `Main.R`

1. Initial setup - download packages
2. Create a list of x observation 
3. Prior Predictive Checking 
- If the gadget is run at this stage, only the prior tab is going to be populated. It is normal for the other tabs to show none.
4. Fit the model - returns a list
5. Map the information into a data frame for consistency and integrity of the data
6. Run the gadget 

Objects in list format

## Flow Diagram

![diagram](raw/diagram.png)

Contact via tkdel34@gmail.com for any questions