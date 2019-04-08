FROM 292075781285.dkr.ecr.us-east-1.amazonaws.com/indra:latest

ENV DIRPATH /sw
ENV PYTHONPATH "${DIRPATH}/indra_db:${PYTHONPATH}"
WORKDIR $DIRPATH

# Install INDRA DB and dependencies.
RUN git clone https://github.com/pagreene/pgcopy.git && \
    cd pgcopy && \
    python setup.py install && \
    cd .. && \
    git clone https://github.com/indralab/indra_db.git && \
    pip list && \
    echo "PYTHONPATH =" $PYTHONPATH && \
    cd indra_db && \
    git checkout $BUILD_BRANCH && \
    echo "BUILD_BRANCH =" $BUILD_BRANCH && \
    git branch && \
    echo "[indra]" > /root/.config/indra/config.ini
