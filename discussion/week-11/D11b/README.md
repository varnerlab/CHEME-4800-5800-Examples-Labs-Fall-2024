# Lab 11a: Let's Build a Random Word Generator
In lecture we introduced Markov models. Let's use the Markov model idea to construct a program that generates random character sequences of defined length as a discrete Markov chain.

### Markov chain and the Markov property
A discrete-time Markov chain is a sequence of random variables $X_{1},\dotsc, X_{n}$ with 
the [Markov property](https://en.wikipedia.org/wiki/Markov_property), 
i.e., the probability of moving to the next state depends only on the present and not past states:
$$
\begin{equation*}
P(X_{n+1} = x | X_{1}=x_{1}, \dots, X_{n}=x_{n}) = P(X_{n+1} = x | X_{n}=y)
\end{equation*}
$$
For finite state spaces, the probability of moving from the state(s) $i\rightarrow{j}$ in the next step, 
is encoded in the transition matrix $p_{ij}\in\mathbf{P}$: 
$$
\begin{equation*}
p_{ij} = P(X_{n+1}~=~j~|~X_{n}~=~i)
\end{equation*}
$$

