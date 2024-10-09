# Lab 7d: Singular Value Decomposition of a Financial Dataset
This lab will familiarize students with Singular Value Decomposition (SVD) and its application to decomposing a financial dataset.

## Task 1: Check the Singular Value Decomposition (SVD) properties
The `runme_task_1.jl` script loads a financial dataset and performs SVD. We gathered daily open-high-low-close (OHLC) values for each firm in the [S&P500](https://en.wikipedia.org/wiki/S%26P_500) between `01-03-2018` and `03-13-2024`, along with data for a few exchange-traded funds and volatility products during that time; let's call this collection of assets $\mathcal{P}$, and assume we have $N$ days worth of data. Using this data, we can compute the daily annualized growth rate (return) for $\forall i\in\mathcal{P}$ as follows:
$$
\begin{equation*}
\mu^{(i)}_{j,j-1} = \frac{1}{\Delta{t}}\cdot\ln\left(\frac{S^{(i)}_j}{S^{(i)}_{j-1}}\right)\quad\text{for}\quad j = 2,3,\ldots,N
\end{equation*}
$$
where $S^{(i)}_{\star}$ is the price of the asset at time $t = \star$ and $\Delta{t}$ is the time difference between time steps $j$ and $j-1$ (in this case `1-trading-day` or 1/252 years). We saved the daily growth (returns) in the $|\mathcal{P}|\times{N}$ array `market_matrix::Array{Float64,2}` where each row is a different asset $i\in\mathcal{P}$, and each column is a different day $j=1,2,\dots{N}$. We then 
computed the SVD of the `market_matrix` and saved the results in the `U,` `S,` and `V` matrices.

__Duration 30 minutes__: Complete the implementation of the `testme_task_1.jl` script that tests facts about singular value decomposition that we discussed in lecture `L7c`. When you have implemented the tests, run the `testme_task_1.jl` script:
```julia
include("testme_task_1.jl")
```
to verify your implementation. The solution to this task can be found in the `solutions` directory. 

## Task 2: Singular Value Decomposition of Financial Data
__Duration 5 minutes__: Run the `runme_task_2.jl` script:
```julia
include("runme_task_2.jl")
```
to compute the cumulative contribution of each mode to the overall `market_matrix.` This script will save the `Fig-SingularValues.pdf` file, which contains a plot of each mode's cumulative contribution. Guestimate the modes needed to capture 80% of `market_matrix` dynamics.

## Task 3: Generate the SVD frames of the market matrix
__Duration 10 minutes__: In the `runme_task_3.jl` script, enter the modes needed to capture 80% of the `market_matrix` in the `my_frame_cutoff` variable. Run the `runme_task_3.jl` script: 
```julia
include("runme_task_3.jl")
```
This script will generate the SVD frames of the cumulative contribution of each mode and will save an image of the SVD `market_matrix` frames to the `frames` directory. Compare the first and last frames; what do you observe? __Colors__: White: down days, Black: up days, Gray: in between.

