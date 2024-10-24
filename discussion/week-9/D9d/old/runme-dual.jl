# include -
using JuMP
using GLPK
using LinearAlgebra

# setup some constants -
number_of_products = 5;
number_of_processes = 4;

# Setuo system -
c = [18.0,25.0,10.0,12.0,15.0]; # profits for each product

# System constraint matrix
A = [
    1.2 1.3 0.7 0.0 0.5 ;
    0.7 2.2 1.6 0.5 1.0 ;
    0.9 0.7 1.3 1.0 0.8 ;
    1.4 2.8 0.5 1.2 0.6 ;
];

b = [160, 200, 120, 280]; # Setup the right hand side vector

# build a model -
model = Model(GLPK.Optimizer)

# add decision variables to the model -
@variable(model, y[i=1:number_of_processes] >= 0) # this sets up 5 variables

# Set the objective => maximize the profit -
@objective(model, Min, transpose(b)*y);

# Setup the constraints - add them to the model 
@constraints(model, 
    begin
        transpose(A)*y .>= c
    end
);

# solve the model
optimize!(model)
solution_summary(model)

# show the solution
for i in 1:number_of_processes
    println("y$i = ",value(y[i]), " units per week.")
end

# print objective value -
println("Objective value for the dual is: ", objective_value(model))