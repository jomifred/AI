#!/bin/bash

if [ ! `docker ps -qf "ancestor=azathoth/pddl"` ]; then
  docker run -p 25000:5000 -t -v "$(pwd)":/x azathoth/pddl &
fi

while [ ! `docker ps -qf "ancestor=azathoth/pddl"` ]; do
  echo "waiting docker solver..."
  sleep 1
done

docker exec -it $(docker ps -qf "ancestor=azathoth/pddl" ) \
   /root/planners/Metric-FF/ff -o /x/domain-jars.pddl -f /x/problem-jars.pddl -s 5

# the following does not solve the problem
#
#docker exec -it $(docker ps -qf "ancestor=azathoth/pddl" ) \
#   /root/planners/optic-clp /x/domain-jars.pddl /x/problem-jars.pddl

# docker run --rm -v "$(pwd)":/x aibasel/downward \
#   --alias lama-first \
#   /x/domain-jars.pddl /x/problem-jars.pddl
