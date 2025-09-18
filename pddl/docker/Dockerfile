# docker build . -t jomifred/pddlplanutils:v2
# docker run -p 5555:5555 --privileged jomifred/pddlplanutils:v2

FROM aiplanning/planutils:latest

RUN pip3 install flask

# Install solvers and tools
RUN planutils install -y val
RUN planutils install -y planning.domains

RUN planutils install -y smtplan

RUN planutils install -y popf
RUN planutils install -f -y tfd

RUN planutils install -y optic

#RUN planutils install -f -y enhsp-2020
RUN planutils install -f -y metric-ff

RUN planutils install -f -y dual-bfws-ffparser
RUN planutils install -f -y delfi
RUN planutils install -f -y lama
RUN planutils install -f -y lama-first


EXPOSE 5555

CMD planutils server --port 5555 --host 0.0.0.0
