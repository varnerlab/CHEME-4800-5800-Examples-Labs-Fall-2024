"""
    μ(dataset::Dict{String, DataFrame}, firms::Array{String,1}; 
        Δt::Float64 = (1.0/252.0), risk_free_rate::Float64 = 0.0) -> Array{Float64,2}
"""
function μ(dataset::Dict{String, DataFrame}, 
    firms::Array{String,1}; Δt::Float64 = (1.0/252.0), risk_free_rate::Float64 = 0.0)::Array{Float64,2}

    # initialize -
    number_of_firms = length(firms);
    number_of_trading_days = nrow(dataset["AAPL"]);
    growth_matrix = Array{Float64,2}(undef, number_of_trading_days-1, number_of_firms);

    # main loop -
    for i ∈ eachindex(firms) 

        # get the firm data -
        firm_index = firms[i];
        firm_data = dataset[firm_index];

        # compute the log returns -
        for j ∈ 2:number_of_trading_days
            S₁ = firm_data[j-1, :volume_weighted_average_price];
            S₂ = firm_data[j, :volume_weighted_average_price];
            growth_matrix[j-1, i] = (1/Δt)*log(S₂/S₁) - risk_free_rate;
        end
    end

    # return -
    return growth_matrix;
end


"""
    ⊗(a::Array{Float64,1},b::Array{Float64,1}) -> Array{Float64,2}

Compute the outer product of two vectors `a` and `b` and returns a matrix.

### Arguments
- `a::Array{Float64,1}`: a vector of length `m`.
- `b::Array{Float64,1}`: a vector of length `n`.

### Returns
- `Y::Array{Float64,2}`: a matrix of size `m x n` such that `Y[i,j] = a[i]*b[j]`.
"""
function ⊗(a::Array{Float64,1},b::Array{Float64,1})::Array{Float64,2}

    # initialize -
    m = length(a)
    n = length(b)
    Y = zeros(m,n)

    # main loop 
    for i ∈ 1:m
        for j ∈ 1:n
            Y[i,j] = a[i]*b[j]
        end
    end

    # return 
    return Y
end

"""
    encode(A::Array{Float64,2}, logic::Function) -> Array{Int64,2}

Encode a matrix `A` using a logic function `logic` and returns a matrix of integers.

### Arguments
- `A::Array{Float64,2}`: a matrix of size `m x n`.
- `logic::Function`: a function that takes a float and returns an integer.

### Returns
- `B::Array{Int64,2}`: a matrix of size `m x n` such that `B[i,j] = logic(A[i,j])`.
"""
function encode(A::Array{Float64,2}, logic::Function)::Array{Int64,2}

    # initialize -
    (m,n) = size(A)
    B = zeros(Int64, m, n)

    # main loop -
    for i ∈ 1:m
        for j ∈ 1:n
            B[i,j] = logic(A[i,j])
        end
    end

    # return -
    return B
end