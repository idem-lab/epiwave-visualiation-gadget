# Epiwave Visualisation Gadget

## Project Structure

```text
project/
│
├── Main.R                          # Main workflow script
│
├── raw/                            # Placeholder and static assets
│   ├── data.csv
│   ├── homepage.txt
│   └── diagram.png
│
├── www/                            # Front-end resources
│   ├── style.css
│   └── script.js
│
└── R/                              # Core application logic
    ├── diagnose_model.R
    ├── download_plot.R
    ├── epiwaveVisualisationGadget.R
    ├── extract_model_info.R
    ├── fit_model.R
    ├── plot_convergence.R
    ├── plot_posterior_check.R
    ├── plot_prior_check.R
    ├── prior_check.R
    ├── summarise_greta.R
    └── validate_model.R
```

## Getting Started

The recommended workflow is to run all steps from `Main.R`.

### 1. Install and Load Dependencies

Ensure all required packages are installed and loaded before proceeding.

### 2. Prepare Input Data

Create a list of predictor observations (`x_obs`) to be supplied to the model.

### 3. Perform Prior Predictive Checks

Run the prior predictive simulation to assess whether the specified priors generate plausible outcomes.

**Note:**
If the gadget is launched at this stage, only the **Prior Predictive Check** tab will contain results. All remaining tabs will remain empty until a model has been fitted. This is expected behaviour.

### 4. Fit the Model

Fit the model using the prepared observations. The fitting process returns model outputs in list format.

### 5. Standardise Outputs

Map the returned objects into a consistent data frame structure. This ensures compatibility across visualisation, diagnostic, and reporting components.

### 6. Launch the Gadget

Run the visualisation gadget to explore prior checks, posterior checks, diagnostics, and model outputs.

## Data Structure

Model outputs and intermediate objects are primarily stored as lists before being transformed into standardised data frames for downstream visualisation and analysis.

## Flow Diagram

![diagram](raw/diagram.png)

## Support

For questions, feedback, or bug reports, please contact:

**[tkdel34@gmail.com](mailto:tkdel34@gmail.com)**
