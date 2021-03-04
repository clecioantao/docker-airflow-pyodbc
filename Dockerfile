# VERSION 1.10.9
# AUTHOR: Matthieu "Puckel_" Roisil
# DESCRIPTION: Basic Airflow container
# BUILD: docker build --rm -t puckel/docker-airflow .
# SOURCE: https://github.com/puckel/docker-airflow

FROM puckel/docker-airflow:1.10.9
LABEL maintainer="clecio"

USER root

RUN set -ex \
    && apt-get update -yqq \
    && apt-get install unixodbc-dev -yqq -yqq \
    && pip install --upgrade pip \
    && pip3 install pyodbc \
    && apt install gnupg -yqq \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EB3E94ADBE1229CF \
    && curl https://packages.microsoft.com/config/debian/10/prod.list > /etc/apt/sources.list.d/mssql-release.list \
    && apt-get update -yqq \
    && ACCEPT_EULA=Y apt-get install msodbcsql17 -yqq \
    && ACCEPT_EULA=Y apt-get install mssql-tools -yqq \
    && export PATH="$PATH:/opt/mssql-tools/bin" \
    && echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile \
    && echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc \
    && . ~/.bashrc \
    && apt-get install unixodbc-dev -yqq \
    && apt-get install libgssapi-krb5-2 -yqq
