# Author: Jacob Anderson
# EightPuzzle.jl will read and execute commands from test.jl using the functions below
using .Iterators

module EightPuzzle


    current_state = [[0, 1, 2], [3, 4, 5], [6, 7, 8]]
    max_nodes = 0;


    # Sets current_state as state arg, then outputs it to the terminal
    function setState(state::Array{Array{Int, 1}})
        global current_state = state
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


    # Permutes the current puzzle state by specifying which direction to move the blank tile in
    function move(direction::String)
        
        # locate the blank tile
        blank_pos = findfirst(isequal(0), collect(Iterators.flatten(current_state)))
        
        # Identify tile to be swapped using the position of the blank tile and the specified move ("l","d","u","r")
        if blank_pos == 1
            
            # For each case, the blank tile index obtains the tile info of the appropriate tile, and the other tile becomes the blank tile
            if direction == "d"
                current_state[1][1] = current_state[2][1]
                current_state[2][1] = 0
                printState()
            
            elseif direction == "r"
                current_state[1][1] = current_state[1][2]
                current_state[1][2] = 0
                printState()
            
            else
                println("invalid move") 
            
            end
        
        elseif blank_pos == 2
            
            if direction == "l"
                current_state[1][2] = current_state[1][1]
                current_state[1][1] = 0
                printState()

            elseif direction == "d"
                current_state[1][2] = current_state[2][2]
                current_state[2][2] = 0
                printState()

            elseif direction == "r"
                current_state[1][2] = current_state[1][3]
                current_state[1][3] = 0
                printState()
            
            else
                pritnln("invalid move")

            end

        elseif blank_pos == 3

            if direction == "l"
                current_state[1][3] = current_state[1][2]
                current_state[1][2] = 0
                printState()

            elseif direction == "d"
                current_state[1][3] = current_state[2][3]
                current_state[2][3] = 0
                printState()

            else
                println("invalid move")

            end

        elseif blank_pos == 4

            if direction == "u"
                current_state[2][1] = current_state[1][1]
                current_state[1][1] = 0
                printState()

            elseif direction == "r"
                current_state[2][1] = current_state[2][2]
                current_state[2][2] = 0
                printState()

            elseif direction == "d"
                current_state[2][1] = current_state[3][1]
                current_state[3][1] = 0
                printState()

            else
                println("invalid move at 4")

            end

        elseif blank_pos == 5

            if direction == "l"
                current_state[2][2] = current_state[2][1]
                current_state[2][1] = 0
                printState()

            elseif direction == "u"
                current_state[2][2] = current_state[1][2]
                current_state[1][2] = 0
                printState()

            elseif direction == "d"
                current_state[2][2] = current_state[3][2]
                current_state[3][2] = 0
                printState()

            elseif direction == "r"
                current_state[2][2] = current_state[2][3]
                current_state[2][3] = 0
                printState()

            else
                println("invalid move")

            end

        elseif blank_pos == 6
        
            if direction == "u"
                current_state[2][3] = current_state[1][3]
                current_state[1][3] = 0
                printState()

            elseif direction == "l"
                current_state[2][3] = current_state[2][2]
                current_state[2][2] = 0
                printState()

            elseif direction == "d"
                current_state[2][3] = current_state[3][3]
                current_state[3][3] = 0
                printState()

            else
                println("invalid move")

            end

        elseif blank_pos == 7

            if direction == "u"
                current_state[3][1] = current_state[2][1]
                current_state[2][1] = 0
                printState()

            elseif direction == "r"
                current_state[3][1] = current_state[3][2]
                current_state[3][2] = 0
                printState()

            else
                println("invalid move")

            end

        elseif blank_pos == 8

            if direction == "l"
                current_state[3][2] = current_state[3][1]
                current_state[3][1] = 0
                printState()

            elseif direction == "u"
                current_state[3][2] = current_state[2][2]
                current_state[2][2] = 0
                printState()

            elseif direction == "r"
                current_state[3][2] = current_state[3][3]
                current_state[3][3] = 0
                printState()

            else
                println("invalid move")

            end
        
        elseif blank_pos == 9

            if direction == "l"
                current_state[3][3] = current_state[3][2]
                current_state[3][2] = 0
                printState()

            elseif direction == "u"
                current_state[3][3] = current_state[2][3]
                current_state[2][3] = 0
                printState()

            else
                println("invalid move")

            end
        end 
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