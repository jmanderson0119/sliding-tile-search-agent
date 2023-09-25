# Author: Jacob Anderson
# EightPuzzle.jl will read and execute commands from test.jl using the functions below

module EightPuzzle

    current_state = [[0, 1, 2], [3, 4, 5], [6, 7, 8]]
    max_nodes = 0;

    # Sets current_state as state arg, then outputs it to the terminal
    function setState(state::Array{Array{Int, 1}})
        global current_state = state
        printState()
    end

    # Outputs the current state as a list, read left to right, top ot bottom 
    function printState()
        println("********************")
        println("Current State:")
        
        for row in current_state
            for i in row
                print("$i ")
            end
        end

        println()
        println("********************")
    end

    function move(direction::String)
    end

    function randomizeState(actionNum::Int)
    end

    function solve_AStar(heuristic::Int)
    end

    function beam(states::Int)
    end

    # Defines a threshold of nodes to be considered during a search
    function maxNodes(nodeNum::Int)
        max_nodes = nodeNum
    end

end