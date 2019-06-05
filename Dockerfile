FROM 292075781285.dkr.ecr.us-east-1.amazonaws.com/indra:grounding

ARG BUILD_BRANCH

ENV DIRPATH /sw
ENV PYTHONPATH "${DIRPATH}/indra_db:${PYTHONPATH}"
WORKDIR $DIRPATH

# Install libpq5
RUN apt-get update && \
    apt-get install -y libpq5 libpq-dev

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

# Install indra_db
RUN git clone https://github.com/indralab/indra_db.git && \
    cd indra_db && \
    pip list && \
    echo "PYTHONPATH =" $PYTHONPATH && \
    git checkout $BUILD_BRANCH && \
    echo "BUILD_BRANCH =" $BUILD_BRANCH && \
    git branch && \
    echo "[indra]" > /root/.config/indra/config.ini

