# include -
using JuMP
using GLPK
using LinearAlgebra

# setup some constants -
number_of_products = 5;
number_of_processes = 4;

# Setup the system A, b and c -
# Define the system matrix -
A = [
    1.2 1.3 0.7 0.0 0.5 ;
    0.7 2.2 1.6 0.5 1.0 ;
    0.9 0.7 1.3 1.0 0.8 ;
    1.4 2.8 0.5 1.2 0.6 ;
];

b = [160, 200, 120, 280]; # Setup the right hand side vector
c_vector = [18.0,25.0,10.0,12.0,15.0]; # profits for each product

# build a model -
model = model = Model(GLPK.Optimizer)

# add decision variables to the model -
@variable(model, x[i=1:number_of_products] >= 0) # this sets up 5 variables

# Set the objective => maximize the profit -
@objective(model, Max, transpose(c_vector)*x);

# Setup the constraints - add them to the model 
@constraints(model, 
    begin
        A*x .<= b
    end
);

# solve the model
optimize!(model)
solution_summary(model)

# show the solution
for i in 1:number_of_products
    println("C$i = ",value(x[i]), " units per week.")
end

# print objective value -
println("Objective value for the primal is: ", objective_value(model), " \$ per week")