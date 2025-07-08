#!/bin/bash
CREATE ROLE mlflow WITH LOGIN PASSWORD '';

CREATE DATABASE mlflow_db OWNER mlflow
    ENCODING = 'UTF8'
    LC_COLLATE = 'en_US.UTF-8'
    LC_CTYPE = 'en_US.UTF-8'
    TEMPLATE = template0;

ALTER DATABASE mlflow_db OWNER TO mlflow;
