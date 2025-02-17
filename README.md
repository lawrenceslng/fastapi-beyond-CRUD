# Assignment #7: Github Actions for FastAPI Beyond CRUD 

**Note**: This is a fork of the repository [FastAPI Beyond CRUD](https://github.com/jod35/fastapi-beyond-CRUD). For the original README, click on the link.

This repository is created to demonstrate the use of Github actions for Assignment #7 of the Spring 2025 DevOps course at USF with the following requirements:

- GitHub actions that verify that Conventional Commits were used during PR creation. Close the PR if a user does not follow the Conventional Commit and send a notification about the failure.
- Create nightly builds (12am) from Main and push the container image to a container registry of choice. If test cases fail, the nightly build fails and cannot be stored in the registry, and a notification is sent to users.
- Use https://sendgrid.com/en-us or https://ethereal.email/ to send emails.
- No extra download of any kind. I will run “docker compose up”. This is for me to verify the project running.

The writeup below lists the items done in order to satisfy the requirements.

## Steps

1. The original repository was forked and cloned locally. Attempts to follow the [Project Setup](https://github.com/jod35/fastapi-beyond-CRUD?tab=readme-ov-file#project-setup) steps and running the project via `docker compose up` command failed due to Python version compatibility issues and missing commands to run the database migration during the docker setup procedure. The following remedies were done:
    - I used python 3.12.9 instead of 3.13.2 to create the virtual environment.
    - I added `pytest==8.3.4` to requirements.txt for running the unit tests.
    - I modified the `Dockerfile` to run the following command instead of just starting the server: `CMD /bin/sh -c "alembic upgrade head && fastapi run src --port 8000 --host 0.0.0.0"`. This makes sure the database migration is done as the docker containers are being started up if only the command `docker compose up` is run without doing the previous project setup steps.

2. I followed the steps to create a `.env` file. The values for the file are listed below and considered non-sensitive for sharing purposes:
```
DATABASE_URL=postgresql+asyncpg://postgres:testpass@db:5432/bookly
JWT_SECRET=randomJWTSECRETtouse123
JWT_ALGORITHM=HS256
REDIS_HOST=localhost
REDIS_PORT=6379
REDIS_URL=redis://redis:6379
MAIL_USERNAME=chance.hintz38@ethereal.email
MAIL_PASSWORD=z7UrtPGsrn7zFKMRKD
MAIL_SERVER=smtp.ethereal.email
MAIL_PORT=587
MAIL_FROM=chance.hintz38@ethereal.email
MAIL_FROM_NAME="Lawrence's Ethereal Email"
DOMAIN=localhost:8000
```

3. I first tackled this requirement:
```
GitHub actions that verify that Conventional Commits were used during PR creation. Close the PR if a user does not follow the Conventional Commit and send a notification about the failure.
```
To do so, I created `Conventional_Commit.yaml` under `.github/workflows` in the root directory. The workflow is setup to run on all PRs and it uses `webiny/action-conventional-commits@v1.3.0` to check if the commit messages follow Conventional Commit formatting and "sends" an email via Ethereal.mail to my email using the Github action `dawidd6/action-send-mail` if it fails the check. The video demonstrating this can be seen in [this section](#video-demonstration).

4. Once that is successful, I moved onto the following requirement:
```
Create nightly builds (12am) from Main and push the container image to a container registry of choice. If test cases fail, the nightly build fails and cannot be stored in the registry, and a notification is sent to users.
```

I created `Nightly_Build.yaml` to do this. It performs a workflow at a specified time (cronjob) and first runs all the unit tests. If the tests fail, an email would be "sent" via Ethereal.mail and the Github action will stop. If the tests pass, the Github action will proceed to build and upload the container images to the following public DockerHub repositories:
- [fastapi-beyond-crud-web](https://hub.docker.com/repository/docker/lawrenceslng/fastapi-beyond-crud-web/general)
- [fastapi-beyond-crud-celery](https://hub.docker.com/repository/docker/lawrenceslng/fastapi-beyond-crud-celery/general)

If uploading unsuccessful, an email would once again be "sent".

5. In order to run the tests and upload the images to DockerHub, secrets have to be set for the Github repository. Here is a glimpse of the secrets set up:
![](/README_resources/image.png)


A demonstration of the failure and success cases for running the tests and uploading to DockerHub are also available in [this section below](#video-demonstration).

## Video Demonstration

random change