# Lab 10b: Estimating the Parameters in a Single Index Model (SIM)
A single index model describes the return of a firm’s stock in terms of a firm-specific return and the overall market return. One of the simplest (yet still widely used) single index models was developed by [Sharpe (1963)](https://en.wikipedia.org/wiki/Single-index_model#:~:text=The%20single%2Dindex%20model%20(SIM,used%20in%20the%20finance%20industry.)).

Let $R_{i}(t)\equiv\left(r_{i}\left(t\right) - r_{f}\right)$ 
and $R_{m}(t)\equiv\left(r_{m}\left(t\right)-r_{f}\right)$ denote the firm-specific and market __excess returns__, where $r_{f}$ denotes the risk-free rate of return.
Further, let $\epsilon_{i}\left(t\right)$ denote stationary normally distributed random noise
with mean zero and standard deviation $\sigma_{i}$. Then, the single index model of Sharpe is given by:

$$
\begin{equation*}
R_{i}\left(t\right) = \alpha_{i}+\beta_{i}\cdot{R}_{m}\left(t\right)+\epsilon_{i}
\left(t\right)\qquad{t=1,2,\dots,T}
\end{equation*}
$$

where $\alpha_{i}$ and $\beta_{i}$ are (unknown) model parameters: 
* $\alpha_{i}$ describes the firm-specific return not explained by the market; thus, $\alpha_{i}$ is the idiosyncratic return of firm $i$.
* $\beta_{i}$ has two interpretations. First, it measures the relationship between the excess return of firm $i$ and the excess return of the market. A large $\beta_{i}$ suggests that the market returns (or losses) are amplified for firm $i$, while a small $\beta_{i}$ suggests that the market returns (or losses) are damped for firm $i$. Second, it represents the relative risk of investing in a firm $i$ relative to the overall market.

## Tasks
1. __Duration 40 min__: Finish the implementation of the `θ` function in the [Compute.jl file](src/Compute.jl) class. The `θ` function should return the estimated parameters $\hat{\alpha}_{i}$ and $\hat{\beta}_{i}$ for a given firm $i$ in the dataset. Please look at the documentation in the [Compute.jl file](src/Compute.jl) for more details.
2. __Duration 10 min__: Let's run a few examples together to test the implementation of the `θ` function. We should be able to validate the values of $\hat{\beta}_{i}$ for a given firm $i$ in the dataset by looking at online resources such as [Yahoo Finance](https://finance.yahoo.com).
