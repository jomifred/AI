#!/bin/bash

docker run -p 25000:5000 -t -v "$(pwd)":/x azathoth/pddl &
docker exec -it $(docker ps -qf "ancestor=azathoth/pddl" ) \
   /root/planners/Metric-FF/ff -o /x/domain-jars.pddl -f /x/problem-jars.pddl
