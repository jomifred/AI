
## to run

run 

    ./solve.sh

it starts a docker and runs the solver.

## using VS code plugin:

start docker solver:

    docker run -p 5555:5555 --privileged jomifred/pddlplanutils:v2

configure the VS code PDDL plugin to use planutils with

    http://localhost:5555/package		
    
run solver selecting Optic solver
