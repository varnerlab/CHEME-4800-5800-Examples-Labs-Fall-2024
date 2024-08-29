"""
    function build(modeltype::Type{MyFibonacciSequenceModel}, data::NamedTuple) -> MyFibonacciSequenceModel

The `build` function is a factory method that creates a new instance of the `MyFibonacciSequenceModel` type. 
The function takes two arguments: `modeltype` and `data`. 
    
### Arguments
- `modeltype::Type{MyFibonacciSequenceModel}`: The type of the model to be created.
- `data::NamedTuple`: A NamedTuple containing the data required to build the model.

The `data::NamedTuple` must contain the following fields:
- `n::Int64`: The number of elements in the Fibonacci sequence. 

### Returns
- `model::MyFibonacciSequenceModel`: A new (empty) instance of the `MyFibonacciSequenceModel` type.

To populate the model with the Fibonacci sequence, pass the model instance to the `fibonacci` function, along with a Iteration model instance.
"""
function build(modeltype::Type{MyFibonacciSequenceModel}, data::NamedTuple)
    
    # initialize -
    model = modeltype();
    n = data.n;

    # check: is the value of n passed in by the user legit? n>=1
    # ...

    model.n = n;
    model.sequence = Dict{Int64, Int64}(); # initialize the sequence with an empty dictionary

    # return -
    return model
end