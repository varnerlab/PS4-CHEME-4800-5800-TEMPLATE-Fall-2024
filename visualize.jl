let

    base_graphmodel = my_graphmodel;
    f = primal_solution["argmax"];

    # setup coordinates for the nodes -
    # these coordinates are for the balanced example -
    node_coordinates = [
    
        10.0 10.0 ; # 1 source node s 
        
        # machine nodes -
        11.0 11.0 ; # 2 machine node 
        11.0 10.0 ; # 3 machine node
        11.0 9.0 ; # 4 machine node
        11.0 8.0 ; # 5 machine node
    
        # product nodes -
        12.0 11.0 ; # 6 product node 
        12.0 10.0 ; # 7 product node
        12.0 9.0 ; # 8 product node
        12.0 8.0 ; # 9 product node
        12.0 7.0 ; # 10 product node
    
        # sink market nodes -
        13.0 11.0; # 11 sink node t 
        13.0 10.0; # 12 sink node t 
        13.0 9.0; # 13 sink node t 
        13.0 8.0; # 14 sink node t 
        13.0 7.0; # 15 sink node t
    ];
    q = plot();
    for (k,v) ∈ base_graphmodel.edgesinverse

        # get the flow value from the solution for this edge index -
        flow_value = f[k];
        
        # now, get the source,target node index for this edge
        s = v[1];
        t = v[2];

        # plot -
        if (flow_value != 0.0)
            plot!([node_coordinates[s,1], node_coordinates[t,1]],[node_coordinates[s,2], node_coordinates[t,2]], arrow=true, color=:black, lw=3, label="")
        else
            plot!([node_coordinates[s,1], node_coordinates[t,1]],[node_coordinates[s,2], node_coordinates[t,2]], arrow=true, color=:gray90, lw=2, label="")
        end
    end
    scatter!(node_coordinates[:,1], node_coordinates[:,2], axis=nothing, border=:none, label="", c=:gray, ms=6)
    current()
end