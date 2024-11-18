include("problemsetup.jl"); # this is the same for both primal and dual problems

# -- SETUP THE LINEAR PROGRAMMING PROBLEM -------------------------------------- #
A = my_graphmodel.A;
b = my_graphmodel.b; # right-hand side vector

# Bounds: setup the lb, ub vectors -
number_of_edges = length(my_graphmodel.edges);
lb = Array{Float64,1}(undef, number_of_edges);
ub = Array{Float64,1}(undef, number_of_edges);
for i ∈ 1:number_of_edges
    j = my_graphmodel.edgesinverse[i]; # get the (target,source) node tuple for edge i
    edge_model = my_graphmodel.edges[j]; # get the edge model
    lb[i] = edge_model[2]; # lower bound
    ub[i] = edge_model[3]; # upper bound
end

# Objective coefficient vector: setup the objective function coefficients vector c -
machine_nodes = [2,3,4,5];
product_nodes = [6,7,8,9,10];
number_of_edges = length(my_graphmodel.edges);
c = zeros(number_of_edges);
for i in 1:number_of_edges
    
    # get source,target node ids -
    node_id_tuple = my_graphmodel.edgesinverse[i];
    edge_model = my_graphmodel.edges[node_id_tuple];

    source_node_id = node_id_tuple[1];
    target_node_id = node_id_tuple[2];
    if source_node_id ∈ machine_nodes && target_node_id ∈ product_nodes
        c[i] = -1*edge_model[1]; # weight for the edge
    else
        c[i] = edge_model[1]; # weight for the edge
    end
end
# ------------------------------------------------------------------------------ #

# -- SOLVE THE LINEAR PROGRAMMING PROBLEM -------------------------------------- #
primal_model = build(MyLinearProgrammingProblemModel, (
    A = A,
    b = b,
    c = c,
    lb = lb,
    ub = ub
));

# solve the linear programming problem -
primal_solution = nothing;
try
    global primal_solution = solve(primal_model); # global keyword is used to make the variable available outside the try block
catch error
    println("Error: ", error);
end
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