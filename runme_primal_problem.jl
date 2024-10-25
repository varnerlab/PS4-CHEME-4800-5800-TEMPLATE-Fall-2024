include("problemsetup.jl"); # this is the same for both primal and dual problems

# -- SETUP THE LINEAR PROGRAMMING PROBLEM -------------------------------------- #
throw("Setup A, b, c, lb, ub - not implemented yet");
# ------------------------------------------------------------------------------ #

# -- SOLVE THE LINEAR PROGRAMMING PROBLEM -------------------------------------- #
primal_model = nothing; # TODO: create the linear programming model
throw("Build the the linear programming model - not implemented yet");

# solve the linear programming problem -
primal_solution = nothing; # TODO: solve the linear programming problem
throw("Solve the linear programming problem - not implemented yet");
# ----------------------------------------------------------------------------- #

# --- SAVE SOLUTION ----------------------------------------------------------- #
include("visualize.jl") # run the script, this visualizes the solution
savefig(joinpath(_PATH_TO_RESULTS, "my_primal_solution.pdf"));

# save the solution -
save(joinpath(_PATH_TO_RESULTS, "my_primal_solution.jld2"), Dict(
    "primal_solution" => primal_solution,
    "my_graphmodel" => my_graphmodel,
    "my_nodecapacities" => my_nodecapacities,
    "primal_model" => primal_model
));
# ------------------------------------------------------------------------------ #