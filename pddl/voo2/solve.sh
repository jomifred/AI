#!/bin/bash

if [ ! `docker ps -qf "ancestor=azathoth/pddl-temporal"` ]; then
  docker run -p 25000:5001 -t -v "$(pwd)":/x azathoth/pddl-temporal &
fi

while [ ! `docker ps -qf "ancestor=azathoth/pddl-temporal"` ]; do
  echo "waiting docker solver..."
  sleep 1
done


# Optic find solution with cost 13
#docker exec -it $(docker ps -qf "ancestor=azathoth/pddl-temporal" ) \
#   /root/planners/optic-clp /x/domain.pddl /x/problem.pddl

docker exec -it $(docker ps -qf "ancestor=azathoth/pddl-temporal" ) \
   /root/planners/temporal/popf3-clp -e /x/domain.pddl /x/problem.pddl
