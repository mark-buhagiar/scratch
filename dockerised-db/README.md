# Dockerised DB
## Goal
Sometimes we need to run integration tests against a proper MS SQL Server db rather than in-memory or SQLite. The requirment was to restore the database schema from a DB Project. The one in this project was generated using Azure Data Studio. While this POC only has a blank db, this can be adjusted using post deployment scripts.

## How to use
1. Make sure docker is installed (duh)
1. `docker-compose up --build`

## What does it do
### Docker-compose
Specifies a service called `db`. The context (location of the dockerfile) is this dir `.`. Passes in 2 args, the name of the DB (must match the name of the DB project) and a password to use for SQL Server's SA user.

### dockerfile
This is a multi-stage dockerfile.

#### Stage 1 (build stage)

Uses the .net sdk to build the db project.

#### Stage 2

1. Uses the 2022 latest mssql server docker image
1. Accepts 2 args as provided by docker-compose
1. Sets the `SA_PASSWORD` env var
1. Copies from the `buildStage` the .dacpac files
1. Sets the user back to `ROOT` because we were having perm issues in the `RUN` command
1. Does the following in a single docker layer
    1. Starts SQL Server in the background, and waits until it sees the service broker message, which shows everything is good to go
    1. Downloads the SQL Package binaries, which lets us publish the dacpac file to the server, unzips, and makes it executable
    1. Publishes the dacpac to SQL Server
    1. Runs a SQL command against the new BD to change the recovery mode