## Example: Product Development Score

NewCo Inc is developing a new food product formulation whose quality is measured using 7200 features, e.g., taste, mouthfeel, storage life, acidity, etc. NewCo has tested 100 different product formulations and has manually scored the overall quality of these formulations.  

NewCo Inc would like to replace expensive manual testing with an automated system that predicts a product quality score from a combination of the 7200 feature scores. 

Develop a linear regression model that computes the overall product score from the feature scores.

### Data
* The product samples are contained in the `sample.csv` file, where each row is a different product formulation, and each column is a feature score. 
* The overall product scores are contained in the `score.cvs` file, where each row is a different overall product score. 

### Model
In this example we compute the minimum norm solution for the unknown regeression parameters $\mathbf{\beta}$.


