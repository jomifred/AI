# docker build . -t jomifred/pddlplanutils
# docker run -p 5555:5555 --privileged jomifred/pddlplanutils

FROM aiplanning/planutils:latest

RUN pip3 install flask

# Install solvers and tools
RUN planutils install -y val
RUN planutils install -y planning.domains
RUN planutils install -y popf

RUN planutils install -y smtplan

RUN planutils install -f -y lama-first
RUN planutils install -f -y tfd

RUN planutils install -y optic

RUN planutils install -f -y enhsp-2020
RUN planutils install -f -y metric-ff

EXPOSE 5555

CMD planutils server --port 5555 --host 0.0.0.0
