# load external packages, and my codes -
include("Include.jl")

# ----------------------------------------------------------------------------------
# for more information on tests, see: https://docs.julialang.org/en/v1/stdlib/Test/
# ----------------------------------------------------------------------------------
# Testset - let's write a unit test for each *public* function in our code!
@testset verbose = true "PS3 Test Suite Primal LP" begin

    # load the primal problem solution archive
    soln_primal_problem = load(joinpath(_PATH_TO_RESULTS, "solution_primal_problem.jld2"));
    my_primal_solution = load(joinpath(_PATH_TO_RESULTS, "my_primal_solution.jld2"));

    @testset "Compare graph component tests" begin
        G_model_soln = soln_primal_problem["my_graphmodel"];
        my_graph_model = my_primal_solution["my_graphmodel"];

        @test typeof(my_graph_model) == MySimpleDirectedGraphModel;
        @test typeof(G_model_soln) == MySimpleDirectedGraphModel;
        @test length(my_graph_model.nodes) == length(G_model_soln.nodes);
        @test length(my_graph_model.edges) == length(G_model_soln.edges);

        # compare the edeges -
        for (k, v) ∈ my_graph_model.edges
            @test haskey(G_model_soln.edges, k);
            @test G_model_soln.edges[k] == v;
        end
    end

    @testset "Compare flow (path) vector" begin
        flow_soln = soln_primal_problem["primal_solution"]["argmax"];
        my_flow = my_primal_solution["primal_solution"]["argmax"];

        @test typeof(my_flow) == typeof(flow_soln);
        @test length(my_flow) == length(flow_soln);
        @test my_flow == flow_soln;
    end
    
    @testset "Compare objective value" begin
        obj_val_soln = soln_primal_problem["primal_solution"]["objective_value"];
        my_obj_val = my_primal_solution["primal_solution"]["objective_value"];

        @test typeof(my_obj_val) == typeof(obj_val_soln);
        @test my_obj_val ≈ obj_val_soln;
    end
end