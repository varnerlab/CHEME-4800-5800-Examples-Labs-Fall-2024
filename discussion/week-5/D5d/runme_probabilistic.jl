# include -
include("Include.jl");

# what rule do we want to see?
colors = 2; # black and white
radius = 3; # radius of the rule - we look at three states
index = 30;
number_of_steps = 240;
number_of_states = 2^8;
Δ = 0;
initial = zeros(Int64, number_of_states);
initial[round(number_of_states/2) |> Int] = 1;

# build a rule model -
rulemodel = build(MyOneDimensionalProbabilisticWolframRuleModel, (
    index=index, colors=colors, radius=radius
));

# run simulation -
frames = solve(rulemodel, initial, steps=number_of_steps, maxnumberofmoves=(number_of_states-Δ));

# Show -
save(File{format"JPEG"}(joinpath(_PATH_TO_FIGS, "R$(index)-F$(number_of_steps)-Probabilistic.jpeg")), 
         Gray.(1 .- frames[number_of_steps]));