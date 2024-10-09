# include runme_task_1 -
include("runme_task_1.jl");

# base frame -
(number_of_rows, number_of_columns) = size(market_matrix);
M = zeros(number_of_rows, number_of_columns);

# let's visualize the SVD of the growth matrix -
my_frame_cutoff = nothing; # TODO: replace this with the number of frames you want to generate;
iter = ProgressBar(1:my_frame_cutoff);
for i ∈ iter

    # compute a new frame -
    global M += Σ[i]*⊗(U[:,i],V[:,i]);

    Bᵢ = encode(M, x-> (
    
        if (x ≥ 0.5) 
            return 2;
        elseif (x ≤ -0.5) 
            return 0;
        else 
            return 1;
        end
    ));
    
    # visualize the result -
    new_frame = Array{Float64,2}(undef, number_of_rows, number_of_columns);
    for j ∈ 1:number_of_rows
        for k ∈ 1:number_of_columns
            if Bᵢ[j,k] == 0
                new_frame[j,k] = 1.0;
            elseif Bᵢ[j,k] == 1
                new_frame[j,k] = 0.5;
            elseif Bᵢ[j,k] == 2
                new_frame[j,k] = 0.0;
            end
        end
    end

    # save the last frame to disk -
    save(File{format"JPEG"}(joinpath(_PATH_TO_MY_FRAMES, "M$(i).jpeg")), 
        Gray.(new_frame));
end