function encode(;p::Array{Float64,1}, labels::Array{Int64,1}, n::Int64)::Array{Int64,1}

    # generate (and sample) a Categorical distribution -
    d = Categorical(p);
    samples = rand(d, n);

    # encode the samples -
    return [labels[samples[i]] for i ∈ 1:n];
end