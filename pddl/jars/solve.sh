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
