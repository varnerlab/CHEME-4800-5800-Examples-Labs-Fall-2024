function _learn(data::Array{Float64,2}, firmindex::Int64, Rₘ::Array{Float64,1}, λ::Float64,
    method::MyMatrixAlgebraLearningMethod):;Array{Float64,1}
    
    # initialize -
    Y = data[firmindex, :];
    max_length = length(Y);
    X = [ones(max_length) Rₘ];
    IM = diagm(ones(2)); # we have two parameters -
      
    # compute θ̂ -
    θ̂ = inv(transpose(X)*X+λ*IM)*transpose(X)*Y

    # return -
    return θ̂;
end

function _learn(data::Array{Float64,2}, firmindex::Int64, Rₘ::Array{Float64,1}, λ::Float64,
    method::MySVDLearingMethod)::Array{Float64,1}

    # initialize -
    Y = data[firmindex, :];
    max_length = length(Y);
    X = [ones(max_length) Rₘ];
    IM = diagm(ones(2)); # we have two parameters -

    # SVD the X -
    (U,d,V) = svd(X);
    Σ = diagm(d);

    # compute θ̂ -
    M = (transpose(Σ)*Σ + λ*IM)*transpose(V);
    θ̂ = inv(M)*transpose(Σ)*transpose(U)*Y;

    # return -
    return θ̂;
end



"""
    θ(data::Array{Float64,2}, firmindex::Int64, Rₘ::Array{Float64,1}; λ::Float64 = 0.0) -> Array{Float64,1}

The `θ` function computes the expected parameters for the single index model.

### Arguments
- `data::Array{Float64,2}`: a matrix of size `m x n` where `m` is the number of firms and `n` is the number of trading days.
- `firmindex::Int64`: an integer representing the index of the firm in the data matrix (row in the `data` matrix).
- `Rₘ::Array{Float64,1}`: a vector of size `n` representing the excess return of the market variable

### Returns
- `θ̂::Array{Float64,1}`: a vector of size `2` representing the expected parameters for the single index model (α, β).

### Optional Arguments
- `λ::Float64 = 0.0`: a float representing the regularization parameter (default is `0.0`).
"""
function θ(data::Array{Float64,2}, firmindex::Int64, Rₘ::Array{Float64,1}; 
    λ::Float64 = 0.0, method::AbstractLearningMethod = MyMatrixAlgebraLearningMethod())::Array{Float64,1}
    return _learn(data, firmindex, Rₘ,  λ,  method);
end