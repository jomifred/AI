#!/bin/bash

docker run -p 25000:5000 -t -v "$(pwd)":/x azathoth/pddl &
docker exec -it $(docker ps -qf "ancestor=azathoth/pddl" ) \
   /root/planners/FF/ff -o /x/domain-bw.pddl -f /x/problem-bw.pddl

#docker exec -it $(docker ps -qf "ancestor=azathoth/pddl" ) \
#   /root/planners/optic-clp -N /x/domain-bw.pddl /x/problem-bw.pddl
