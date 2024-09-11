# include -
include("Include.jl")

# load the data -
y = loaddatafiles(joinpath(_PATH_TO_DATA, "score.csv"));
X = loaddatafiles(joinpath(_PATH_TO_DATA, "sample.csv"));

# let's use 50% of the data for test, 50% for validation
fraction = 0.70
(X_train, X_test) = partition(X; trainfraction = fraction);
(y_train, y_test) = partition(y; trainfraction = fraction);

# compute the min norm soln -
A = transpose(X_train)*inv(X_train*transpose(X_train))
β̂ = A*y_train
ŷ_train = X_train*β̂

# compute Yhat  -
ŷ_test = X_test*β̂
xy_line = -10.0:0.01:10.0 |> collect

# plot -
#scatter(y_train,ŷ_train, xlim=[-10.0,10.0],ylim=[-10,10],label="Product score",c=colorant"#0068AC")
scatter(y_test,ŷ_test, xlim=[-10.0,10.0],ylim=[-10,10],label="Product score",c=colorant"#0068AC")

# add labels, and the 45 line
plot!(xy_line,xy_line,lw=2, label="perfect prediction line", c=colorant"#EF4035");
xlabel!("Measured product score", fontsize=18)
ylabel!("Model computed product score", fontsize=18)