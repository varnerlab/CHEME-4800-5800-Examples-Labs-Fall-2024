let
    # draw the path -
    world = world_model;
    initial_site = startstate;
    absorbing_state_set = Set{Tuple{Int,Int}}()
    
    # find the maximum U for apples and oranges -
    number_of_rows = world.number_of_rows;
    number_of_columns = world.number_of_cols;
    
    max_value = -Inf;
    max_coordinates = (0,0);
    for apples ∈ 1:number_of_rows
        for oranges ∈ 1:number_of_columns
            value = myrewards[(apples,oranges)];
            if (value > max_value)
                max_value = value;
                max_coordinates = (apples,oranges);
            end
        end
    end
    push!(absorbing_state_set, max_coordinates);

    p = plot();
    hit_absorbing_state = false
    s = world.states[initial_site];
    visited_sites = Set{Tuple{Int,Int}}();
    push!(visited_sites, initial_site);
    
    while (hit_absorbing_state == false)
        current_position = world.coordinates[s]
        a = my_π[s];
        Δ = world.moves[a];
        new_position =  current_position .+ Δ

        scatter!([current_position[1]],[current_position[2]], label="", showaxis=:false, msc=:black, c=:red)
        plot!([current_position[1], new_position[1]],[current_position[2], new_position[2]], label="", arrow=true, lw=1, c=:red)
        
        if (in(new_position, absorbing_state_set) == true || in(new_position, visited_sites) == true)
            hit_absorbing_state = true;
        else
            
            if (in(new_position, keys(world_model.states)) == false)
                hit_absorbing_state = true;
            else
                s = world.states[new_position];
                push!(visited_sites, new_position);
            end
        end
    end
    
    # draw the grid -
    for s ∈ 𝒮
        current_position = world.coordinates[s]
        a = my_π[s];
        Δ = world.moves[a];
        new_position =  current_position .+ Δ

        if (in(current_position, soft_wall_set) == true)
            scatter!([current_position[1]],[current_position[2]], label="", showaxis=:false, c=:gray69, ms=4)
        elseif (in(new_position, keys(world_model.states)) == true)
            scatter!([current_position[1]],[current_position[2]], label="", showaxis=:false, msc=:gray50, c=:white)
        end
    end

    # draw the absorbing state -
    scatter!([max_coordinates[1]],[max_coordinates[2]], label="Max: $(max_coordinates[1]),$(max_coordinates[2])", showaxis=:false, msc=:black, c=:green)

    xlabel!("Number of Apples",fontsize=18)
    ylabel!("Number of Oranges",fontsize=18)
    current()
end