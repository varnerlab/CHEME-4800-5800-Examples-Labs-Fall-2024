# include -
include("runme_task_2.jl") # load the A matrix -

# Case 1: we estimate all inputs specie streams. Is this system solvable?
measured_columns = range(4,step=1,length=14) |> collect; # we have measured these columns
unkown_columns = setdiff(1:24, measured_columns); # we want to estimate these columns
A₁ = A[:,unkown_columns];

# Case 2: we measured all inputs species streams, and some of the output species streams. Is this system solvable?
measured_columns = [4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]; # we have measured these columns
unkown_columns = setdiff(1:24, measured_columns); # we want to estimate these columns
A₂ = A[:,unkown_columns];
B₂ = A[:,measured_columns];

# The rank test suggests that we can solve A₂, but not A₁. Generate some random measurements and test this.
ndot_measured = [
    
    # stream 1
    10.0 ; # 1 s1 A1
    0.0 ; # 2 s1 A2
    0.0 ; # 3 s1 B
    0.0 ; # 4 s1 C
    0.0 ; # 5 s1 P
    1.0 ; # 6 s1 x
    0.0 ; # 7 s1 y

    # stream 2
    0.0 ; # 8 s2 A1
    2.0 ; # 9 s2 A2
    0.0 ; # 10 s2 B
    0.0 ; # 11 s2 C
    0.0 ; # 12 s2 P
    0.0 ; # 13 s2 x
    0.0 ; # 14 s2 y

    # stream 3
    7.0 ; # 15 s3 A1
    1.0 ; # 16 s3 A2
    0.0 ; # 17 s3 B
];

# solve -
b = -1*B₂*ndot_measured;
ϵ = 1e-6;
x = solve(A₂, b, ones(length(unkown_columns)), algorithm=MyGaussianEliminationMethod(), ϵ=ϵ, maxiterations=100);