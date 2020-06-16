FROM 292075781285.dkr.ecr.us-east-1.amazonaws.com/indra:db

ARG BUILD_BRANCH
ARG INDRA_BRANCH

ENV DIRPATH /sw
ENV PYTHONPATH "${DIRPATH}/indra_db:${DIRPATH}/covid-19:${PYTHONPATH}"
WORKDIR $DIRPATH

RUN cd indra && \
    git fetch --all && \
    git checkout $INDRA_BRANCH && \
    echo "INDRA_BRANCH=" $INDRA_BRANCH && \
    pip install -e . -U

# Install libpq5 and some other necessities.
RUN apt-get update && \
    apt-get install -y libpq5 libpq-dev postgresql-client postgresql-client-common
RUN pip install awscli

# Update the protmapper
RUN pip install -U git+https://github.com/indralab/protmapper.git

# Install psycopg2
RUN git clone https://github.com/psycopg/psycopg2.git && \
    cd psycopg2 && \
    python setup.py build && \
    python setup.py install

# Install pgcopy
RUN git clone https://github.com/pagreene/pgcopy.git && \
    cd pgcopy && \
    python setup.py install

# Install adeft
RUN pip install adeft
RUN python -m adeft.download

# Install gilda
RUN pip install gilda

# Install covid-19
RUN git clone https://github.com/indralab/covid-19.git

# Install indra_db
RUN git clone https://github.com/indralab/indra_db.git && \
    cd indra_db && \
    pip list && \
    echo "PYTHONPATH =" $PYTHONPATH && \
    git checkout $BUILD_BRANCH && \
    echo "BUILD_BRANCH =" $BUILD_BRANCH && \
    git branch && \
    echo "[indra]" > /root/.config/indra/config.ini

