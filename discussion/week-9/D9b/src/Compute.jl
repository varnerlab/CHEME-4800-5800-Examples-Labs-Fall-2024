function _obj_function(x, utility, model)::Float64

    # evaluate the utility model -
    U_model = evaluate(model, x);

    # compute the error -
    error = (U_model - utility).^2;

    # return -
    return error;
end


"""
    evaluate(model::VLLinearUtilityFunction, dependent::Array{Float64,1}) -> Array{Float64,1}
"""
function evaluate(model::VLLinearUtilityFunction, dependent::Array{T,1})::Float64 where T <: Real

    # get parameters from model -
    α = model.α;
    
    # dot product -
    return sum(α.*dependent);
end

"""
    indifference(model::VLLinearUtilityFunction; 
        utility::Float64=1.0, bounds::Array{T,2}, ϵ::Float64 = 0.01) where T <: Real -> Array{Float64,2}
"""
function indifference(model::VLLinearUtilityFunction; 
    utility::Float64=1.0, bounds::Array{T,1}, ϵ::Float64 = 0.01) where T <: Real

    # how many steps are we going to take?
    number_of_steps = Int(floor((bounds[end] - bounds[1])/ϵ));
    solution = zeros(number_of_steps+1,2);
    α = model.α;

    # loop over the steps -
    for i ∈ 1:(number_of_steps+1)

        # compute the dependent variable -
        x = bounds[1] + ϵ*(i-1);

        # compute the utility -
        solution[i,1] = x;
        solution[i,2] = utility/α[2] - α[1]/α[2]*x;
    end
   
    # return -
    return solution
end