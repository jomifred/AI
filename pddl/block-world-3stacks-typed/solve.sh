#!/bin/bash

docker run -p 25000:5000 -t -v "$(pwd)":/x azathoth/pddl &
# 41 steps
#docker exec -it $(docker ps -qf "ancestor=azathoth/pddl" ) \
#   /root/planners/FF/ff -o /x/domain-bw.pddl -f /x/problem-bw.pddl

# 34 steps
docker exec -it $(docker ps -qf "ancestor=azathoth/pddl" ) \
   /root/planners/optic-clp /x/domain-bw.pddl /x/problem-bw.pddl

# from https://www.fast-downward.org

# 38 steps
#docker run --rm -v "$(pwd)":/x aibasel/downward \
#   --alias lama-first \
#   /x/domain-bw.pddl /x/problem-bw.pddl

# the following finds a wrong solution (!)
#docker run --rm -v "$(pwd)":/x aibasel/downward \
#   /x/domain-bw.pddl /x/problem-bw.pddl \
#   --search "astar(ipdb())"
