# run the taskme__task_1.jl file
include("runme_task_1.jl"); # load the S matrix -

# setup the measurement matrix -
number_of_measured_streams = 2;
number_of_species = length(S.species);
N = zeros(Float64, number_of_species, number_of_measured_streams);

# build the system matrix -
d = [1,1,-1]
A = [S.matrix d[1]*diagm(ones(number_of_species)) d[2]*diagm(ones(number_of_species)) d[3]*diagm(ones(number_of_species))];