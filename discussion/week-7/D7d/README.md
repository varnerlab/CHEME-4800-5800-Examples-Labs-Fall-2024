# Lab 8d: Singular Value Decomposition of a Financial Dataset
This lab will familiarize students with Singular Value Decomposition (SVD) and its application to decomposing a financial dataset.

## Task 1: Check the Singular Value Decomposition (SVD) properties
The `runme_task_1.jl` script loads a financial dataset and performs SVD. We gathered daily open-high-low-close (OHLC) values for each firm in the [S&P500](https://en.wikipedia.org/wiki/S%26P_500) between `01-03-2018` and `03-13-2024`, along with data for a few exchange-traded funds and volatility products during that time. Using this data, we compute the daily annualized return:

$$
\mu_{j,j-1} = \frac{1}{\Delta{t}}\cdot\ln\left(\frac{P_j}{P_{j-1}}\right)
$$

where $P_j$ is the price of the asset at time $j$ and $\Delta{t}$ is the time difference between $j$ and $j-1$ (in this case `1-trading-day` or 1/252 years). We saved the daily returns in a matrix `market_matrix` where each row is a different asset, and each column is a different day. We then computed the SVD of the `market_matrix` and saved the results in the `U,` `S,` and `V` matrices.

* __Duration 30 minutes__: Complete the implementation of the `testme_task_1.jl` script that tests facts about singular value decomposition that we discussed in lecture `L8c`. When you have implemented the tests, run the `testme_task_1.jl` script to verify your implementation. The solution to this task can be found in the `solutions` directory. 

## Task 2: Singular Value Decomposition of Financial Data
__Duration 5 minutes__: Run the `runme_task_2.jl` to compute the cumulative contribution of each mode to the overall 
`market_matrix`. 
* This script will save the `Fig-SingularValues.pdf` file which contains a plot of each mode's cumulative contribution. Guestimate the modes needed to capture 80% of `market_matrix.`

## Task 3: Generate the SVD frames of the market matrix
__Duration 10 minutes__: Enter the approximate modes required to capture 80% of the `market_matrix` in the `my_frame_cutoff` variable. Run the `runme_task_3.jl` to generate the SVD frames of the market matrix. This script will create a plot of the cumulative contribution of each mode and will save an image of the SVD `market_matrix` frames to the `frames` directory. 

* Compare the first and last frame, what do you observe?

__Colors__:
* White: down days
* Black: up days
* Gray: in between

