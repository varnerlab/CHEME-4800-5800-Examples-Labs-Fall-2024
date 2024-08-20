# compute the SVD, etc. 
include("runme_task_1.jl");

# let's plot the singular values, to see how much information is in the singular values -
number_of_modes = length(Σ);
ΣS = (1/sum(Σ))*Σ;
explained_array = [100*sum(ΣS[1:i]) for i ∈ 1:number_of_modes]; # comprehension

# make a plot of the fractional contribution of the singular values
plot(explained_array, label="Scaled σᵢ values", lw=3)
xlabel!("index i", fontsize=18)
ylabel!("Cumulative explained by mode 1 to i", fontsize=18)

# save -
savefig("Fig-SingularValues.pdf")