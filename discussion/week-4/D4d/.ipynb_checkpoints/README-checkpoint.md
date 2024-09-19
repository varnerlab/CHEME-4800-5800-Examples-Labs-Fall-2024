# `Lab-4d`: Working with text data files. Movie reviews and sentiment analysis
Let's teach your computer to read and understand human language!
Ultimately, we will build a system that can classify text as positive or negative in tone, called [sentiment analysis](https://en.wikipedia.org/wiki/Sentiment_analysis). The objective of `lab-4d` is to familiarize students with working with text documents and a simple [natural language processing (NLP)](https://en.wikipedia.org/wiki/Natural_language_processing) model such as the [bag of words model](https://en.wikipedia.org/wiki/Bag-of-words_model).

* We'll use the [Cornell movie review v2.0 data set](http://www.cs.cornell.edu/people/pabo/movie-review-data) as our `corpus.` This data set was introduced and analyzed in [Pang/Lee ACL 2004](https://aclanthology.org/P04-1035/). This data set contains 1000 positive and 1000 negative movie reviews in free(ish) text.

## Prerequisite 
Break up into teams of 2-3 people and take `5 min` to walk through all the files (starting with `Include.jl` in the `root` directory) in `Lab-4d`. At the end of `5 min`, we'll do a class Q&A to ensure everyone understands the purpose of each file.

## Tasks
* __Duration: 20 min__: Break up into teams and `debug` the `readfiles` function in `src/Files.jl` and any other associated files/functions called by `readfiles.` You can test your implementation by running the `runtests.jl` file.
    * The `readfiles` function reads an array of move review file names and returns a `Dict{Int, MyMoviewReviewDocumentModel}` where the key is the index of the review file, and the value is a `MyMoviewReviewDocumentModel` object.
* __Duration 10 min__: Everything is a number. Once the `readfiles` (and any associated) functions are working, let's use a technique called [feature hashing](https://en.wikipedia.org/wiki/Feature_hashing) developed by our very own [Kilian Weinberger](https://www.cs.cornell.edu/~kilian/) to convert the text data into a numerical format. Debug the `hashing_vectorizer` function in `src/Compute.jl`. You can test your implementation by running the `runtests.jl` file.
    * The `hashing_vectorizer` function converts text data into a numerical format. See the [pseudo code in the Wikipedia article for guidance](https://en.wikipedia.org/wiki/Feature_hashing#Pseudocode_implementation).
* __Duration 10 min__: Once the `hashing_vectorizer` function is working, let's compute a [term-document-matrix](https://en.wikipedia.org/wiki/Document-term_matrix) analog  using the `hashing_vectorizer` function and discuss what we get. We've implemented this logic already in the `runme.jl` file. 
