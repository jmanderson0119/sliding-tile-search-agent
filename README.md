# 8-Puzzle
This AI project contends the 8-puzzle or sliding tile puzzle, in which the goal is to permute the puzzle such that the tiles read '0 1 2 3 4 5 6 7 8' when read left-to-right, top-to-bottom'.

# How it Works
This program takes in a text file specifying commands as an argument and performs actions. Primarily, the program can be used to solve the 8-puzzle using a best-first search with a choice of two different heuristic functions and a local beam searching that specifies the number of nodes to keep track of.

# Heuristic Functions
Shortly put, the program can search for solutions using a best-first algorithm on a given puzzle state using one a two heuristics: the first tracks the number of misplaced tile in the puzzle, and the other is a sum of the Euclidean distances representing how far each tile is from its solved position.
