include("Include.jl")

function frame(scene, framenumber, g)
    framenumber == 1 && return

    # run Dijkstra's algorithm

    ds = dijkstra_shortest_paths(g, 1, allpaths=true, trackvertices=true)

    # for which destination vertex?
    destv = framenumber

    # get the vertices on the path
    _, ep = enumerate_paths(ds, [1, destv])

    # convert to edges
    vlist = [Edge(p[1] => p[2]) for p in zip(ep, circshift(ep, -1))]

    # draw background graph
    background("grey10")
    sethue("grey40")
    drawgraph(g, layout=squaregrid, vertexshapes=:none)
    path = Point[]

    # draw shortest path
    drawgraph(g,
        layout=squaregrid,
        vertexlabelfontsizes=30,
        vertexshapes=:none,
        edgelist = vlist[1:end-1],
        edgefunction = (n, s, d, f, t) -> begin
            push!(path, f)
            push!(path, t)
        end)
    sethue("orange")
    setline(10)
    setlinejoin("bevel")
    # poly(path, :stroke, close=false)
    sethue("red")
    # circle.(path[[1, end]], 10, :fill)
end

function main()
    
    path_to_data_file = joinpath(_PATH_TO_DATA, "soc-sign-bitcoinalpha.csv");

    # read the edges -
    myedges = readedgesfile(path_to_data_file, delim=',', comment='#')

    # build the graph -
    dag = build(MySimpleDirectedGraphModel, myedges)
    g = visualize(dag);

    amovie = Movie(600, 600, "dijkstra")
    animate(amovie,
        Scene(amovie, (s, f) -> frame(s, f, g), 1:400),
        framerate=10)
end

main()