
function _jld2(path::String)::Dict{String,Any}
    return load(path);
end

"""
    function loaddatafile(path::String) -> DataFrame
"""
function loaddatafile(path::String)::DataFrame
    return CSV.read(path, DataFrame);
end

MyMarketDataSet() = _jld2(joinpath(_PATH_TO_DATA, "SP500-Daily-OHLC-1-3-2018-to-12-29-2023.jld2"));