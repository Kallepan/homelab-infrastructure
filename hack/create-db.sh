#!/bin/bash
CREATE ROLE mattermost WITH LOGIN PASSWORD '';

CREATE DATABASE mattermost_db OWNER mattermost
    ENCODING = 'UTF8'
    LC_COLLATE = 'en_US.UTF-8'
    LC_CTYPE = 'en_US.UTF-8'
    TEMPLATE = template0;

ALTER DATABASE mattermost_db OWNER TO mattermost;
