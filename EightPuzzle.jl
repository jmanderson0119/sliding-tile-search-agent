# Author: Jacob Anderson
# EightPuzzle.jl will read and execute commands from test.jl using the functions below
using .Iterators

module EightPuzzle

    # Storing current state and the nodes considered in search before error is sent
    current_state = [[0, 1, 2], [3, 4, 5], [6, 7, 8]]
    max_nodes = 0 # threshold
    solution = [] # globally stored solution to search
    nodes_explored = 0 # tracker

    # Goal state to compare the current state to
    goal_state = [[0, 1, 2], [3, 4, 5], [6, 7, 8]]

    # Sets current_state as state arg, then outputs it to the terminal
    function setState(state::Array{Array{Int, 1}})
        global current_state = state
    end


    # Outputs the current state as a list, read left to right, top ot bottom 
    function printState()
        print(" ")
        
        for row in current_state
            for i in row
                print("$i ")
            end
        end

        println()
        println("--------------------")
    end


    # Helper: locates the specififed tile in the current puzzle state
    function locateTile(tile::Int)
        return findfirst(isequal(tile), collect(Iterators.flatten(current_state)))
    end


    # Permutes the current puzzle state by specifying which direction to move the blank tile in
    function move(direction::String)::String
        
        # Locates the blank tile
        blank_pos = locateTile(0)
        
        # Identifies tile to be swapped using the position of the blank tile and the specified move ("l","d","u","r")
        if blank_pos == 1
            
            # For each case, the blank tile index obtains the tile info of the appropriate tile, and the other tile becomes the blank tile
            if direction == "d"
                current_state[1][1] = current_state[2][1]
                current_state[2][1] = 0
                return "d"
            
            elseif direction == "r"
                current_state[1][1] = current_state[1][2]
                current_state[1][2] = 0
                return "r"
                
            else
                println("invalid move") 
                return "invalid move"

            end
        
        elseif blank_pos == 2
            
            if direction == "l"
                current_state[1][2] = current_state[1][1]
                current_state[1][1] = 0
                return "l"

            elseif direction == "d"
                current_state[1][2] = current_state[2][2]
                current_state[2][2] = 0
                return "d"

            elseif direction == "r"
                current_state[1][2] = current_state[1][3]
                current_state[1][3] = 0
                return "r"
            
            else
                println("invalid move")
                return "invalid move"

            end

        elseif blank_pos == 3

            if direction == "l"
                current_state[1][3] = current_state[1][2]
                current_state[1][2] = 0
                return "l"

            elseif direction == "d"
                current_state[1][3] = current_state[2][3]
                current_state[2][3] = 0
                return "d"

            else
                println("invalid move")
                return "invalid move"

            end

        elseif blank_pos == 4

            if direction == "u"
                current_state[2][1] = current_state[1][1]
                current_state[1][1] = 0
                return "u"

            elseif direction == "r"
                current_state[2][1] = current_state[2][2]
                current_state[2][2] = 0
                return "r"

            elseif direction == "d"
                current_state[2][1] = current_state[3][1]
                current_state[3][1] = 0
                return "d"

            else
                println("invalid move")
                return "invalid move"

            end

        elseif blank_pos == 5

            if direction == "l"
                current_state[2][2] = current_state[2][1]
                current_state[2][1] = 0
                return "l"

            elseif direction == "u"
                current_state[2][2] = current_state[1][2]
                current_state[1][2] = 0
                return "u"

            elseif direction == "d"
                current_state[2][2] = current_state[3][2]
                current_state[3][2] = 0
                return "d"

            elseif direction == "r"
                current_state[2][2] = current_state[2][3]
                current_state[2][3] = 0
                return "r"

            else
                println("invalid move")
                return "invalid move"

            end

        elseif blank_pos == 6
        
            if direction == "u"
                current_state[2][3] = current_state[1][3]
                current_state[1][3] = 0
                return "u"

            elseif direction == "l"
                current_state[2][3] = current_state[2][2]
                current_state[2][2] = 0
                return "l"

            elseif direction == "d"
                current_state[2][3] = current_state[3][3]
                current_state[3][3] = 0
                return "d"

            else
                println("invalid move")
                return "invalid move"

            end

        elseif blank_pos == 7

            if direction == "u"
                current_state[3][1] = current_state[2][1]
                current_state[2][1] = 0
                return "u"

            elseif direction == "r"
                current_state[3][1] = current_state[3][2]
                current_state[3][2] = 0
                return "r"

            else
                println("invalid move")
                return "invalid move"

            end

        elseif blank_pos == 8

            if direction == "l"
                current_state[3][2] = current_state[3][1]
                current_state[3][1] = 0
                return "l"

            elseif direction == "u"
                current_state[3][2] = current_state[2][2]
                current_state[2][2] = 0
                return "u"

            elseif direction == "r"
                current_state[3][2] = current_state[3][3]
                current_state[3][3] = 0
                return "r"

            else
                println("invalid move")
                return "invalid move"
                

            end
        
        elseif blank_pos == 9

            if direction == "l"
                current_state[3][3] = current_state[3][2]
                current_state[3][2] = 0
                return "l"

            elseif direction == "u"
                current_state[3][3] = current_state[2][3]
                current_state[2][3] = 0
                return "u"

            else
                println("invalid move")
                return "invalid move"

            end

        # I don't know how this would possibly be reached, just so I know if it somehow happens
        else
            return "invalid puzzle state reached"

        end 
    end


    # Sets the state of the puzzle to a random unsolved state by Permuting the solved state of the puzzle with actionNum random moves
    function randomizeState(actionNum::Int)

        # Generates string of random valid moves of length == actionNum, based on where the blank tile is
        for i in 1:actionNum
            blank_pos = locateTile(0)

            # Chooses amongst legal moves for each blank tile scenario
            if blank_pos == 1
                action = rand(["r", "d"])

            elseif blank_pos == 2
                action = rand(["l", "r", "d"])
                
            elseif blank_pos == 3
                action = rand(["l", "d"])
                
            elseif blank_pos == 4
                action = rand(["u", "r", "d"])

            elseif blank_pos == 5
                action = rand(["l", "u", "r", "d"])

            elseif blank_pos == 6
                action = rand(["u", "l", "d"])

            elseif blank_pos == 7
                action = rand(["u", "r"])

            elseif blank_pos == 8
                action = rand(["r", "u", "l"])

            elseif blank_pos == 9
                action = rand(["l", "u"])

            else
                return "invalid puzzle state reached"

            end

            print(action)
            move(action)
        end
    end


    function solve_AStar(heuristic::Int)
        
        global solution = []

        # Checking if the puzzle has begun in the solved state
        if current_state == goal_state
            println(solution)
            return 0
        end

        while current_state != goal_state

            # Identifying legal moves from the current puzzle state
            blank_pos = locateTile(0)

            if blank_pos == 1
                legal_moves = ["r", "d"]
            
            elseif blank_pos == 2
                legal_moves = ["d", "r", "l"]

            elseif blank_pos == 3
                legal_moves = ["l", "d"]

            elseif blank_pos == 4
                legal_moves = ["d", "r", "u"]

            elseif blank_pos == 5
                legal_moves = ["l", "u", "r", "d"]

            elseif blank_pos == 6
                legal_moves = ["d", "u", "l"]

            elseif blank_pos == 7
                legal_moves = ["u", "r"]

            elseif blank_pos == 8
                legal_moves = ["r", "u", "l"]

            elseif blank_pos == 9
                legal_moves = ["l", "u"]

            else
                println("invalid puzzle state reached")
                return 0

            end

            # Evaluating the heuristic for each successor node and add the optimal move to the solution
            optimal_move = heuristicEvaluation(legal_moves, heuristic)
            move(optimal_move)
            push!(solution, optimal_move)

            # Stops search if max_nodes thresh is hit
            if optimal_move == "max_nodes reached"
                println(solution)
                return 0
            end

            printState()
        end

        println(solution)
        return 0
    end


    # Considers the heuristic being used and the current possibilities, computes the heuristic for each and outputs the optimal move
    function heuristicEvaluation(legal_moves, heuristic)

        heuristic_vals = [] # This is going to store the h(n) of each successor, and use the info to break ties

        # Stores the small h(n) & the corresponding move -- the output of heuristicEvaluation()
        best_heuristic = typemax(Int)
        optimal_move = ""

        # Chooses appropriate heuristic and performs evaluation
        if (heuristic == 1)

            # For each legal move, evaluate h(n) and store the move with the small h(n) in optimal_move
            for action in legal_moves

                # Resets successro h(n) values
                heuristic_vals = []

                # Stop evaluating if the maximum number of nodes to be considered has been hit
                if (nodes_explored == max_nodes)
                    return "max_nodes reached"
                end

                # Tracks number of misplaced tiles
                misplaced_tiles = 0

                move(action)

                # Computes h(n) for the current successor
                for tile in 0:8
                    if locateTile(tile) != (tile + 1)
                        misplaced_tiles += 1
                    end
                end

                push!(heuristic_vals, misplaced_tiles)
                
                # If a new optimal move is identified, its info is stored for comparison with other successor nodes
                if misplaced_tiles <= best_heuristic
                    best_heuristic = misplaced_tiles
                    optimal_move = action
                end

                # Finally, reverting state for further evaluation of other successor nodes
                undo(action)

                global nodes_explored += 1

            end

            # If there is a deadlock, we must ensure that the puzzle doesn't choose to revert to the previous state
            if length(solution) > 0
                if (deadlockTest(heuristic_vals))
                    blank_pos = locateTile(0)

                    if blank_pos == 1
                        if solution[length(solution)] == "l"
                            optimal_move = "d"
                        elseif solution[length(solution)] == "u"
                            optimal_move = "r"
                        end
                    
                    elseif blank_pos == 2
                        if solution[length(solution)] == "r"
                            optimal_move = rand(["d", "r"])
                        elseif solution[length(solution)] == "l"
                            optimal_move = rand(["d", "l"])
                        elseif solution[length(solution)] == "u"
                            optimal_move = rand(["r", "l"])
                        end
        
                    elseif blank_pos == 3
                        if solution[length(solution)] == "r"
                            optimal_move = "d"
                        elseif solution[length(solution)] == "u"
                            optimal_move = "l"
                        end
        
                    elseif blank_pos == 4
                        if solution[length(solution)] == "u"
                            optimal_move = rand(["r", "u"])
                        elseif solution[length(solution)] == "l"
                            optimal_move = rand(["d", "u"])
                        elseif solution[length(solution)] == "d"
                            optimal_move = rand(["d", "r"])
                        end
        
                    elseif blank_pos == 5
                        if solution[length(solution)] == "r"
                            optimal_move = rand(["r", "u", "d"])
                        elseif solution[length(solution)] == "u"
                            optimal_move = rand(["r", "u", "l"])
                        elseif solution[length(solution)] == "l"
                            optimal_move = rand(["l", "u", "d"])
                        elseif solution[length(solution)] == "d"
                            optimal_move = rand(["r", "l", "d"])
                        end
        
                    elseif blank_pos == 6
                        if solution[length(solution)] == "r"
                            optimal_move = rand(["d", "u"])
                        elseif solution[length(solution)] == "d"
                            optimal_move = rand(["l", "d"])
                        elseif solution[length(solution)] == "u"
                            optimal_move = rand(["l", "u"])
                        end
        
                    elseif blank_pos == 7
                        if solution[length(solution)] == "d"
                            optimal_move = "r"
                        elseif solution[length(solution)] == "l"
                            optimal_move = "u"
                        end
        
                    elseif blank_pos == 8
                        if solution[length(solution)] == "l"
                            optimal_move = rand(["l", "u"])
                        elseif solution[length(solution)] == "r"
                            ptimal_move = rand(["r", "u"])
                        elseif solution[length(solution)] == "d"
                            optimal_move = rand(["l", "r"])
                        end
        
                    elseif blank_pos == 9
                        if solution[length(solution)] == "r"
                            optimal_move = "u"
                        elseif solution[length(solution)] == "d"
                            optimal_move = "l"
                        end
                    end 
                end 
            end 

            return optimal_move
        
        elseif (heuristic == 2)

            # For each legal move, evaluate h(n) and store the move with the small h(n) in optimal_move
            for action in legal_moves

                # Stop evaluating if the maximum number of nodes to be considered has been hit
                if (nodes_explored == max_nodes)
                    return "max_nodes reached"
                end

                # Tracks sum of distances for each tile
                manhattan_distances = 0

                move(action)

                # Computes h(n) for the current successor
                for tile in 0:8
                    manhattan_distances += manhattanDistance(tile)
                end

                push!(heuristic_vals, manhattan_distances)

                # If a new optimal move is identified, its info is stored for comparison with other successor nodes
                if manhattan_distances <= best_heuristic
                    best_heuristic = manhattan_distances
                    optimal_move = action
                end

                # Finally, reverting state for further evaluation of other successor nodes
                undo(action)

                global nodes_explored += 1

            end

            # If there is a deadlock, we must ensure that the puzzle doesn't choose to revert to the previous state
            if length(solution) > 0
                if (deadlockTest(heuristic_vals))
                    blank_pos = locateTile(0)

                    if blank_pos == 1
                        if solution[length(solution)] == "l"
                            optimal_move = "d"
                        elseif solution[length(solution)] == "u"
                            optimal_move = "r"
                        end
                    
                    elseif blank_pos == 2
                        if solution[length(solution)] == "r"
                            optimal_move = rand(["d", "r"])
                        elseif solution[length(solution)] == "l"
                            optimal_move = rand(["d", "l"])
                        elseif solution[length(solution)] == "u"
                            optimal_move = rand(["r", "l"])
                        end
        
                    elseif blank_pos == 3
                        if solution[length(solution)] == "r"
                            optimal_move = "d"
                        elseif solution[length(solution)] == "u"
                            optimal_move = "l"
                        end
        
                    elseif blank_pos == 4
                        if solution[length(solution)] == "u"
                            optimal_move = rand(["r", "u"])
                        elseif solution[length(solution)] == "l"
                            optimal_move = rand(["d", "u"])
                        elseif solution[length(solution)] == "d"
                            optimal_move = rand(["d", "r"])
                        end
        
                    elseif blank_pos == 5
                        if solution[length(solution)] == "r"
                            optimal_move = rand(["r", "u", "d"])
                        elseif solution[length(solution)] == "u"
                            optimal_move = rand(["r", "u", "l"])
                        elseif solution[length(solution)] == "l"
                            optimal_move = rand(["l", "u", "d"])
                        elseif solution[length(solution)] == "d"
                            optimal_move = rand(["r", "l", "d"])
                        end
        
                    elseif blank_pos == 6
                        if solution[length(solution)] == "r"
                            optimal_move = rand(["d", "u"])
                        elseif solution[length(solution)] == "d"
                            optimal_move = rand(["l", "d"])
                        elseif solution[length(solution)] == "u"
                            optimal_move = rand(["l", "u"])
                        end
        
                    elseif blank_pos == 7
                        if solution[length(solution)] == "d"
                            optimal_move = "r"
                        elseif solution[length(solution)] == "l"
                            optimal_move = "u"
                        end
        
                    elseif blank_pos == 8
                        if solution[length(solution)] == "l"
                            optimal_move = rand(["l", "u"])
                        elseif solution[length(solution)] == "r"
                            ptimal_move = rand(["r", "u"])
                        elseif solution[length(solution)] == "d"
                            optimal_move = rand(["l", "r"])
                        end
        
                    elseif blank_pos == 9
                        if solution[length(solution)] == "r"
                            optimal_move = "u"
                        elseif solution[length(solution)] == "d"
                            optimal_move = "l"
                        end
                    end 
                end 
            end

            return optimal_move
        end  
    end    
    

    # Tests to see if all available moves produce the same h(n) value -- a deadlock
    function deadlockTest(heuristic_vals)
        for value in heuristic_vals
            if value != heuristic_vals[1]
                return false
            end
        end

        println(true)
        return true
    end


    # Acts as an undo button for the puzzle state; helper function for search
    function undo(action::String)
        actions = ["d", "u", "r", "l"]
        
        if action == "u"
            move(actions[1])

        elseif action == "d"
            move(actions[2])

        elseif action == "l"
            move(actions[3])

        elseif action == "r"
            move(actions[4])

        else
            return "invalid input"
        end
    end

    
    # Computes the manhattan distance for a tile in the current puzzle state
    function manhattanDistance(tile::Int)::Int
        
        # this 2D array stores the manhattan distance for the tile that should be in position i that is currently in position j for the (i , j) entry
        manhattan_distances = [[0, 1, 2, 1, 2, 3, 2, 3, 4], [1, 0, 1, 2, 1, 2, 3, 2, 3], [2, 1, 0, 3, 2, 1, 4, 3, 2], [1, 2, 3, 0, 1, 2, 1, 2, 3], [2, 1, 2, 1, 0, 1, 2, 1, 2], [3, 2, 1, 2, 1, 0, 3, 2, 1], [2, 3, 4, 1, 2, 3, 0, 1, 2], [3, 2, 3, 2, 1, 2, 1, 0, 1], [4, 3, 2, 3, 2, 1, 2, 1, 0]]
        
        return manhattan_distances[tile + 1][locateTile(tile)]
    end

        
    function beam(states::Int)
    end


    # Defines a threshold of nodes to be considered during a search
    function maxNodes(nodeNum::Int)
        global max_nodes = nodeNum
    end

    setState([[0, 1, 2], [3, 4, 5], [6, 7, 8]])
    randomizeState(5)
    printState()
    maxNodes(50)
    solve_AStar(1)
end
