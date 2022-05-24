# PDDL Examples

These examples are used in the [AI](https://jomifred.github.io/ia/) course of Prof. Jomi.

## Blocks World

I have some solutions for the tradicional Block World example. In all of them, the main actions are:

* `pickup`: the robot removes a block from the table.
* `putdown`: the robot puts the block it is holding on the table.
* `unstack`: the robot takes a block that is on top of another block.
* `stack`: the robot puts the block it is holding on top of another block.

The implementations:

* folder `block-world`: this is a very simple implementation that considers a table having infinite places (all blocs can be placed on top of the table). The goal is a set of stacks, their place in the table are ignored.

* folder `block-world-3stacks`: in this version the table has only 3 stacks and the goal defines the stacks and their place.

* folder `block-world-3stacks-typed`: types were added for the objects.
