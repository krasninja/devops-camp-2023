# -----------------------------------------------
# The created image contains Python application that
# tries to allocate a lot of memory cause container OOM.
#
# You can run it like this:
# docker run --rm -m 30m --name oom krasninja/python-oom:0.1.0
#
# The image will be terminated. Then you can check the
# exit status:
# docker inspect oom | jq ".[].State"
#
# The "OOMKilled" flag should be "true".
# -----------------------------------------------


# Prepare Python builder and prepare virtual env with necessary packages.
FROM python:3.11-slim AS builder
COPY ./testtask/requirements.txt /app/requirements.txt
RUN python -m venv /venv && \
 /venv/bin/pip install --upgrade --no-cache-dir pip && \
 /venv/bin/pip install --no-cache-dir -r /app/requirements.txt

# Create distroless container.
FROM gcr.io/distroless/python3-debian11@sha256:57dbab565d405ce5ae9c7a8c781c95fa229655cb8381d0e5db4ece28661fa687
COPY --from=builder /venv /venv
COPY ./testtask /app
WORKDIR /app
ENV PYTHONPATH="/venv/lib/python3.11/site-packages:$PYTHONPATH"
ENTRYPOINT ["/usr/bin/python3", "memory.py"]
