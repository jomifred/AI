# PDDL Examples

These examples are used in the [AI](https://jomifred.github.io/ia/) course of Prof. Jomi.

## Blocks World

I have some solutions for the traditional Block World example. In all of them, the main actions are:

* `pickup`: the robot removes a block from the table.
* `putdown`: the robot puts the block it is holding on the table.
* `unstack`: the robot takes a block that is on top of another block.
* `stack`: the robot puts the block it is holding on top of another block.

The implementations:

* folder `block-world`: this is a very simple implementation that considers a table having infinite places (all blocs can be placed on top of the table). The goal is a set of stacks, their place in the table are ignored.

* folder `block-world-3stacks`: in this version the table has only 3 stacks and the goal defines the stacks and their place.

* folder `block-world-3stacks-typed`: types were added for the objects.

You can use the [this web site](http://editor.planning.domains) to run the solver.

## Jugs

### Problem description

You are given a 4 liter jug and a 3 liter jug. Both the jugs are initially empty. The jugs don’t have markings to allow measuring smaller quantities.

Considering that (X, Y) corresponds to a state where X refers to the amount of water in Jug1 and Y refers to the amount of water in Jug2, determine the path from the initial state (0, 0) to the final state (2,0).

The operations you can perform are:

* Empty a Jug, (X, Y)->(0, Y) Empty Jug 1
* Fill a Jug, (0, 0)->(4, 0) Fill Jug 1
* Pour water from one jug to the other until one of the jugs is either empty or full, (X, Y) -> (X-d, Y+d)

### Solution

The PDDL specification for this problem is in folder `jars`. It considers

* cost of actions
* functions

(the `solve.sh` script uses docker to run a solver)

## Missionaries and Cannibals

We start from a very simple solution (`v0` -- that does not consider constraints) and improve it on better (shorter) versions. `v3` is the best I could write, with only one action.
