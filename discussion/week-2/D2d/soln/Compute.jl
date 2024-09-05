# -- PRIVATE METHODS BELOW HERE ------------------------------------------------------------------------------------------------------- #
function _fibonacci(sequencemodel::MyFibonacciSequenceModel, iterationmodel::MyForLoopIterationModel)

    # initialize -
    n = sequencemodel.n;
    sequence = Dict{Int64, Int64}();

    # we know the first two elements -
    sequence[0] = 0;
    sequence[1] = 1;

    # main loop, compute F₂, ....
    for i ∈ 2:n # what is this short-hand for?
        sequence[i] = sequence[i-1] + sequence[i-2]
    end

    # update the model -
    sequencemodel.sequence = sequence;
end

function _fibonacci(sequencemodel::MyFibonacciSequenceModel, iterationmodel::MyWhileLoopIterationModel)

    # check: is n legit?
    n = sequencemodel.n;
    sequence = Dict{Int64, Int64}();
    
    # main loop 
    should_loop_continue = true
    i = 0;
    while (should_loop_continue == true)
       
        # conditional logic: hardcode 0, 1 else gets all other cases
        if (i == 0)
            sequence[i] = 0; 
        elseif (i == 1)
            sequence[i] = 1;
        else
            sequence[i] = sequence[i - 1] + sequence[i - 2]
        end

        # update i -
        i += 1; # this is short-hand for i = i + 1

        # check: should we go around again?
        if (i>n)
            should_loop_continue = false;
        end
    end
    
    # update the model -
    sequencemodel.sequence = sequence;
end
# -- PRIVATE METHODS ABOVE HERE ------------------------------------------------------------------------------------------------------- #

# -- PUBLIC METHODS BELOW HERE -------------------------------------------------------------------------------------------------------- #
"""
    function fibonacci!(sequencemodel::MyFibonacciSequenceModel, iterationmodel::AbstractIterationModel)

This function computes the Fibonacci sequence for a given model. The model is updated in place (the sequencemodelmodel is mutable). 
The iteration model is used to determine the type of loop to use.

# Arguments
- `sequencemodel::MyFibonacciSequenceModel`: The sequence model to update. The sequence model must have a field `n::Int64` that is the number of elements to compute.
- `iterationmodel::AbstractIterationModel`: The iteration model to use for the calculation. The iteration model must be a subtype of `AbstractIterationModel`.

There is no return value. The `sequencemodel` is updated in place.
"""
function fibonacci!(sequencemodel::MyFibonacciSequenceModel, iterationmodel::AbstractIterationModel)
    _fibonacci(sequencemodel, iterationmodel);
end
# -- PUBLIC METHODS ABOVE HERE -------------------------------------------------------------------------------------------------------- #