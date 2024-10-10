
"""
    function loaddatafile(path::String) -> DataFrame
"""
function loaddatafile(path::String)::DataFrame
    return CSV.read(path, DataFrame);
end