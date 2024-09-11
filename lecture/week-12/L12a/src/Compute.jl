function lookahead(p::MyMDPProblemModel, U::Vector{Float64}, s::Int64, a::Int64)

    # grab stuff from the problem -
    R = p.R;  # reward -
    T = p.T;    
    γ = p.γ;
    𝒮 = p.𝒮;
    
    # setup my state array -
    return R[s,a] + γ*sum(T[s,s′,a]*U[i] for (i,s′) in enumerate(𝒮))
end

function lookahead(p::MyMDPProblemModel, U::Function, s::Int64, a::Int64)

    # get data from the problem -
    𝒮, T, R, γ = p.𝒮, p.T, p.R, p.γ;
    return R[s,a] + γ*sum(T[s,s′,a]*U(s′) for s′ in 𝒮)
end


function myrandpolicy(problem::MyMDPProblemModel, 
    world::MyRectangularGridWorldModel, s::Int)::Int

    # initialize -
    d = Categorical([0.25,0.25,0.25,0.25]); # you specify this

    # should keep chooseing -
    should_choose_gain = true;
    a = -1; # default
    while (should_choose_gain == true)
    
        # initialize a random categorical distribution over actions -
        aᵢ = rand(d);
        
        # get the move, and the current location -
        Δ = world.moves[aᵢ];
        current_position = world.coordinates[s]
        new_position =  current_position .+ Δ
        if (haskey(world.states, new_position) == true)
            a = aᵢ
            should_choose_gain = false;
        end
    end

    return a;
end;

function myrandstep(problem::MyMDPProblemModel, 
    world::MyRectangularGridWorldModel, s::Int, a::Int)

    # get the reward value -
    r = problem.R[s,a];

    # get the move, and the current location -
    Δ = world.moves[a];
    current_position = world.coordinates[s]

    # propose a new position -
    new_position =  current_position .+ Δ
    s′ = s; # default, we don't do anything
    if (haskey(world.states, new_position) == true)
        s′ = world.states[new_position];
    end

    # return -
    return (s′,r)
end;

function myrollout(problem::MyMDPProblemModel, 
    world::MyRectangularGridWorldModel, s::Int64, depth::Int64)::Float64

    # initialize -
    ret = 0.0;
    for i ∈ 1:depth
        s, r = myrandpolicy(problem, world, s) |> a -> myrandstep(problem, world, s, a);
        ret += problem.γ^(i-1)*r;
    end
    
    # return -
    return ret;
end;

function Q(p::MyMDPProblemModel, U::Array{Float64,1})::Array{Float64,2}

    # grab stuff from the problem -
    R = p.R;  # reward -
    T = p.T;    
    γ = p.γ;
    𝒮 = p.𝒮;
    𝒜 = p.𝒜

    # initialize -
    Q_array = Array{Float64,2}(undef, length(𝒮), length(𝒜))

    for s ∈ 1:length(𝒮)
        for a ∈ 1:length(𝒜)
            Q_array[s,a] = R[s,a] + γ*sum([T[s,s′,a]*U[s′] for s′ in 𝒮]);
        end
    end

    return Q_array
end

function policy(Q_array::Array{Float64,2})::Array{Int64,1}

    # get the dimension -
    (NR, _) = size(Q_array);

    # initialize some storage -
    π_array = Array{Int64,1}(undef, NR)
    for s ∈ 1:NR
        π_array[s] = argmax(Q_array[s,:]);
    end

    # return -
    return π_array;
end

function backup(problem::MyMDPProblemModel, U::Array{Float64,1}, s::Int64)
    return maximum(lookahead(problem, U, s, a) for a ∈ problem.𝒜);
end

function solve(model::MyValueIterationModel, problem::MyMDPProblemModel)::MyValueFunctionPolicy
    
    # data -
    k_max = model.k_max;

    # initialize
    U = [0.0 for _ ∈ problem.𝒮];

    # main loop -
    for _ ∈ 1:k_max
        U = [backup(problem, U, s) for s ∈ problem.𝒮];
    end

    return MyValueFunctionPolicy(problem, U);
end

function iterative_policy_evaluation(p::MyMDPProblemModel, π, k_max::Int)

    # grab stuff from the problem -
    R = p.R;  # reward -
    T = p.T;    
    γ = p.γ;
    𝒮 = p.𝒮;

    # initialize value -
    U = [0.0 for s ∈ 𝒮];

    for _ ∈ 1:k_max
        U = [lookahead(p, U, s, π(s)) for s ∈ 𝒮]
    end

    return U;
end

function greedy(problem::MyMDPProblemModel, U::Array{Float64,1}, s::Int64)
    u, a = findmax(a->lookahead(problem, U, s, a), problem.𝒜);
    return (a=a, u=u)
end

(π::MyValueFunctionPolicy)(s::Int64) = greedy(π.problem, π.U, s).a;
