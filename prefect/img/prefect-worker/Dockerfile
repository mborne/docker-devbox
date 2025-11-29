FROM prefecthq/prefect:3-latest

RUN pip install -U prefect-docker

# add --base-job-template with networks defaulted to ["devbox"]
RUN mkdir /config
COPY base-job-template.json /config/.
