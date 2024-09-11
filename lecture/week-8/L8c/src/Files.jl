function loaddatafiles(path::String)::Union{Array{Float64,1}, Array{Float64,2}}
    return readdlm(path);
end