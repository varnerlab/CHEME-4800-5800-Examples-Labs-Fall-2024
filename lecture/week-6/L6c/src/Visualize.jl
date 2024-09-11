function _manhattanline(pt1, pt2)
    poly([pt1,pt2], :stroke)
end

function _writeframe(graph::SimpleDiGraph, visited::Set{Int64}, start::Int64, frameindex::Int64)
     
    # initialize -
    frame_path = joinpath(_PATH_TO_FRAMES, "frame_$(frameindex).png");

    Drawing(600,600, frame_path)
    origin()
    background("grey10")
    sethue("gray69")
    fontsize(8)
    drawgraph(graph, 
        edgelabels = :none, edgecurvature=0, edgegaps = 0.0, layout=stress,
        edgelines = (k, s, d, f, t) -> _manhattanline(f, t),
        vertexlabels = (v) -> v ∈ visited ? "$(v)" : "",
        vertexshapesizes = (v) -> (v ∈ visited ? 10.0 : 0.01),
        vertexfillcolors = (v) -> (v ∈ visited ? colorant"orange" : colorant"gray69"),
        vertexstrokecolors = (v) -> (v ∈ visited ? colorant"orange" : colorant"gray69"),
        edgestrokeweights = (n, from, to, edgesrc, edgedest) -> (from ∈ visited && to ∈ visited ? 2.0 : 0.5), 
        edgestrokecolors= (n, from, to, edgesrc, edgedest) -> (from ∈ visited && to ∈ visited ? colorant"orange" : colorant"gray69"));
    finish()
end

function _writeframe(graph::SimpleDiGraph, visited::Set{Int64}, frameindex::Int64)
     
    # initialize -
    frame_path = joinpath(_PATH_TO_FRAMES, "frame_$(frameindex).png");

    Drawing(600,600, frame_path)
    origin()
    background("grey10")
    sethue("gray69")
    fontsize(8)
    drawgraph(graph, 
        edgelabels = :none, edgecurvature=0, edgegaps = 0.0, layout=stress,
        edgelines = (k, s, d, f, t) -> _manhattanline(f, t),
        vertexlabels = (v) -> v ∈ visited ? "$(v)" : "",
        vertexshapesizes = (v) -> (v ∈ visited ? 10.0 : 0.01),
        vertexfillcolors = (v) -> (v ∈ visited ? colorant"orange" : colorant"gray69"),
        vertexstrokecolors = (v) -> (v ∈ visited ? colorant"orange" : colorant"gray69"),
        edgestrokeweights = (n, from, to, edgesrc, edgedest) -> (from ∈ visited && to ∈ visited ? 2.0 : 0.5), 
        edgestrokecolors= (n, from, to, edgesrc, edgedest) -> (from ∈ visited && to ∈ visited ? colorant"orange" : colorant"gray69"));
    finish()
end