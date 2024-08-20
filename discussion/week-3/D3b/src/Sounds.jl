function _play_sound(array::Array{T,1}; 
    sounds::Union{Nothing, Dict{Int64, Tuple{Matrix{Float64}, Float32}}} = nothing)::Nothing where T <: Number

    if (sounds !== nothing)
    
        # initialize -
        N = length(array) # how many elements in the array?
        for k ∈ 1:N
            
            a() = begin
                y, fs = sounds[array[k]]
                wavplay(y,fs) # play the sound: there maybe a bug here in WAV.jl. Maybe I'm using it wrong?
            end
            
            b = Task(a);
            schedule(b);
            wait(b);
        end  
    end

    # return sorted array -
    return nothing
end