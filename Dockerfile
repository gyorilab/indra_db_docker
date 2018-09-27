FROM 292075781285.dkr.ecr.us-east-1.amazonaws.com/indra:latest

ENV DIRPATH /sw
WORKDIR $DIRPATH

# Install INDRA and dependencies
RUN git clone https://github.com/indralab/indra_db.git && \
    cd indra_db && \
    git checkout master

