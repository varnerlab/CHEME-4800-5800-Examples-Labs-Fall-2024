# Lab 11a: Let's Build a Random Markov Word Generator
In the lecture, we introduced Markov models. Let's construct a program that generates random character sequences of defined length using a discrete Markov chain.

### Background: Markov chain and the Markov property
A discrete-time Markov chain is a sequence of random variables $X_{1},\dotsc, X_{n}$ with 
the [Markov property](https://en.wikipedia.org/wiki/Markov_property), 
i.e., the probability of moving from the current state to the next state depends only on the current states and not past states:
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

In this lab, we will build a Markov model that generates random words. We will use a dataset of English words to construct the transition matrix $\mathbf{P}$, where the states of our system will be the characters in the words. After calculating $\mathbf{P}$, we'll sample from this matrix to generate random words.

### Tasks
We downloaded a JSON file containing approximately 370K English words from [here](https://github.com/dwyl/english-words). The file is in the `data` directory. Let's use this data to build a Markov model that generates random words.

* We already implemented the code to read the words from the `JSON` file and to build an instance of the `MyEnglishLanguageVocubularyModel` struct. Furthermore, we have implemented the `samples(...)` function, which generates a set of random words of a given length from $\mathbf{P}$. However, the `transitionmatrix(...)` function (which constructs $\mathbf{P}$) has not been implemented.

* __Duratrion: 30 min__: Using the `MyEnglishLanguageVocubularyModel` instance, implement the `transitionmatrix(...)` function in `src/Compute.jl`. This function generates the Markov model's transition matrix $\mathbf{P}$. Assume the states are the characters in the words. Thus, the transition matrix will be a $26\times{26}$ matrix where $p_{ij}\in\mathbf{P}$ is the probability of moving from character $i$ to character $j$. Let's compute $p_{ij}$ using the first two characters of each word to make our lives easier. 

* A soluiton implementation is provided in the `solution` directory.

Test your `transitionmatrix(...)` implementation by executing the `runme.jl` script from the terminal:
```julia
include("runme.jl")
```
The script will generate `100` random words of length `4` starting with the character `t.`