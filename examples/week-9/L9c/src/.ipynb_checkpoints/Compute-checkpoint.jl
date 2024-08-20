function _children(edges::Dict{Tuple{Int64, Int64}, Tuple{Float64, Float64, Float64}}, id::Int64)::Set{Int64}
    
    # initialize -
    childrenset = Set{Int64}();
    
    # Dumb implementation - why?
    for (k, _) ∈ edges
        if k[1] == id
            push!(childrenset, k[2]);
        end
    end

    # return -
    return childrenset;
end

"""
    function children(graph::T, node::MyGraphNodeModel) -> Set{Int64} where T <: MyAbstractGraphModel
"""
function children(graph::T, node::MyGraphNodeModel)::Set{Int64} where T <: MyAbstractGraphModel
    return graph.children[node.id];
end

function weight(graph::T, source::Int64, target::Int64)::Float64 where T <: MyAbstractGraphModel
    return graph.edges[(source, target)];
end

function indifference(problem::MySimpleCobbDouglasChoiceProblem, U::Float64, xlim::Array{Float64,1})::Array{Float64,2}

    # initialize -
    α = problem.α
    α₁ = α[1]
    α₂ = α[2]

    # set values for the good and service 1
    X1 = range(xlim[1], stop=xlim[2], step = 0.001) |> collect;
    d = length(X1);

    Y = Array{Float64,2}(undef,d,2);
    for j ∈ 1:d

        tmp = (1/α₂)*(log(U) - α₁*log(X1[j]));

        Y[j,1] = X1[j];
        Y[j,2] = exp(tmp);
    end

    # return -
    return Y;
end

function budget(problem::T, xlim::Array{Float64,1})::Array{Float64,2} where {T <: AbstractSimpleChoiceProblem}

    # initialize -
    c = problem.c;
    I = problem.I;

    # set values for the good and service 1
    X1 = range(xlim[1], stop=xlim[2], step = 0.001) |> collect;
    d = length(X1);

    Y = Array{Float64,2}(undef,d,2);
    for j ∈ 1:d

        tmp = (1/c[2])*(I - c[1]*X1[j]);

        Y[j,1] = X1[j];
        Y[j,2] = tmp
    end

    # return -
    return Y;
end
