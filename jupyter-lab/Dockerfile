FROM python:3.9-slim-buster
LABEL maintainer="Asif Mohammad Mollah <mrasif.in>"

RUN pip install --no-cache-dir jupyterlab

# Your custom dependencies start here...

RUN pip install --no-cache-dir \
    numpy \
    pandas \
    pymongo \
    sshtunnel \
    setuptools \
    wheel \
    fpdf \
    weasyprint \
    mitosheet \
    duckdb \
    gradio

# Your custom dependencies end here...

WORKDIR /app

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
