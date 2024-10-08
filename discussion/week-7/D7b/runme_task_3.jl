# include -
include("runme_task_2.jl") # load the A matrix -

# setup -
total_number_of_unknowns = 17;

# Case 1: we estimate all inputs in stream 1. Is this system solvable?
measured_columns = range(4,step=1, length=7) |> collect; # we have measured these columns
unkown_columns = setdiff(1:total_number_of_unknowns, measured_columns); # we want to estimate these columns
A₁ = A[:,unkown_columns];

# Case 2: we measured all inputs species streams, and some of the output species streams. Is this system solvable?
measured_columns = [1,2,3,11,12,13,14,15,16,17]; # we have measured these columns
unkown_columns = setdiff(1:total_number_of_unknowns, measured_columns); # we want to estimate these columns
A₂ = A[:,unkown_columns];
B₂ = A[:,measured_columns];

# The rank test suggests that we can solve A₂, but not A₁. Generate some random measurements and test this.
ndot_measured = [
    
    # reactions -
    1.3  ; # 1 R1
    1.0  ; # 2 R2
    1.1  ; # 3 R3

    # outputs -
    1.67  ; # 11 A1
    1.0  ; # 12 A2
    1.0  ; # 13 B
    1.2  ; # 14 C
    1.0  ; # 15 P
    1.0  ; # 16 x
    12.45  ; # 17 y
];

# solve -
b = -1*B₂*ndot_measured;
ϵ = 1e-6;
x = solve(A₂, b, ones(length(unkown_columns)), algorithm=MyGaussSeidelMethod(), ϵ=ϵ, maxiterations=100);