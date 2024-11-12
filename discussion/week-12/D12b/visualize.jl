include("Include.jl")

let 
    # draw the path -
    s = (1,10);
    number_of_steps = 20;

    for i ∈ 1:number_of_steps
    
        a = action(planner, SA[s[1],s[2]]); # get the action for the state (1,2)
        Δ = (0,0); # initialize the move, with stay in the same place
        if (a == :up)
            Δ = (0,1)
        elseif (a == :down)
            Δ = (0,-1)
        elseif (a == :left)
            Δ = (-1,0)
        elseif (a == :right)
            Δ = (1,0)
        end

        s_next = (s[1]+Δ[1], s[2]+Δ[2]);

        @show s, a, s_next;
        s = s_next;
    end


    # draw the grid -
    # for s ∈ 𝒮
        
    #     current_position = world.coordinates[s]
    #     a = my_π[s];
    #     Δ = world.moves[a];
    #     new_position =  current_position .+ Δ
        
    #     if (haskey(rewards, current_position) == true && rewards[current_position] == charging_reward)
    #         scatter!([current_position[1]],[current_position[2]], label="", showaxis=:false, c=:green, ms=6)
    #     elseif (haskey(rewards, current_position) == true && rewards[current_position] == lava_reward)
    #         scatter!([current_position[1]],[current_position[2]], label="", showaxis=:false, c=:red, ms=6)
    #     else (in(current_position, soft_wall_set) == true)
    #         scatter!([current_position[1]],[current_position[2]], label="", showaxis=:false, c=:gray69, ms=4)
    #     end
    # end
end