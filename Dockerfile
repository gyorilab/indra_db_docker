FROM 292075781285.dkr.ecr.us-east-1.amazonaws.com/indra:latest

ENV DIRPATH /sw
WORKDIR $DIRPATH

# Install INDRA and dependencies
RUN git clone https://github.com/indralab/indra_db.git && \
    pip list && \
    echo $PYTHONPATH && \
    export PYTHONPATH=.:$PYTHONPATH:indra_db && \
    cd indra_db && \
    git checkout $BUILD_BRANCH && \
    echo $BUILD_BRANCH && \
    git branch && \
    mkdir /root/.config && \
    mkdir /root/.config/indra && \
    echo "[indra]" > /root/.config/indra/config.ini && \
    git checkout master &&

