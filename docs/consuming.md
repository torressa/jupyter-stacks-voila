# Consuming

The easiest way of using this repo for you own project is to,

1. Clone this repo into your project
2. Modify the paths in the `docker/.env` file to match the structure (for instance `PROJECTDIR=../..` and `JUPYTERSTACKSDIR=..`).
3. Modify the contents of the docker files both `Dockerfile` and `docker-compose.yml` to add jupyter extenstions, different file names, testing, ...

This way you'll have your own local copy catered to your project.

For a better solution, for some version control, fork the repo and do the same thing but adding
the fork as a submodule instead of cloning. Then after making the changes, you can push to the fork.
