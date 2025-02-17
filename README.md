# Assignment #7: Github Actions for FastAPI Beyond CRUD 

This is a fork of the repository [FastAPI Beyond CRUD](https://github.com/jod35/fastapi-beyond-CRUD). For the original README, click on the link.

This repository is created to demonstrate the use of Github actions for Assignment #7 of the Spring 2025 DevOps course at USF with the following requirements:

```
- GitHub actions that verify that Conventional Commits were used during PR creation. Close the PR if a user does not follow the Conventional Commit and send a notification about the failure.
- Create nightly builds (12am) from Main and push the container image to a container registry of choice. If test cases fail, the nightly build fails and cannot be stored in the registry, and a notification is sent to users.
- Use  https://sendgrid.com/en-us or https://ethereal.email/ to send emails.
- No extra download of any kind. I will run “docker compose up”. This is for me to verify the project running.
```

## Steps

- copy .env and init file
- adjust dockerfile to run migration
- make Conventional_Commit.yaml

## TO BE CLEANED UP BELOW
------------------------------------------------------------------------------------------


This is the source code for the [FastAPI Beyond CRUD](https://youtube.com/playlist?list=PLEt8Tae2spYnHy378vMlPH--87cfeh33P&si=rl-08ktaRjcm2aIQ) course. The course focuses on FastAPI development concepts that go beyond the basic CRUD operations.

For more details, visit the project's [website](https://jod35.github.io/fastapi-beyond-crud-docs/site/).


## Table of Contents

1. [Getting Started](#getting-started)
2. [Prerequisites](#prerequisites)
3. [Project Setup](#project-setup)
4. [Running the Application](#running-the-application)
5. [Running Tests](#running-tests)
6. [Contributing](#contributing)

## Getting Started
Follow the instructions below to set up and run your FastAPI project.

### Prerequisites
Ensure you have the following installed:

- Python >= 3.10
- PostgreSQL
- Redis

### Project Setup
1. Clone the project repository:
    ```bash
    git clone https://github.com/jod35/fastapi-beyond-CRUD.git
    ```
   
2. Navigate to the project directory:
    ```bash
    cd fastapi-beyond-CRUD/
    ```

3. Create and activate a virtual environment:
    ```bash
    python3 -m venv env
    source env/bin/activate
    ```

4. Install the required dependencies:
    ```bash
    pip install -r requirements.txt
    ```

5. Set up environment variables by copying the example configuration:
    ```bash
    cp .env.example .env
    ```

6. Run database migrations to initialize the database schema:
    ```bash
    alembic upgrade head
    ```

7. Open a new terminal and ensure your virtual environment is active. Start the Celery worker (Linux/Unix shell):
    ```bash
    sh runworker.sh
    ```

## Running the Application
Start the application:

```bash
fastapi dev src/
```
Alternatively, you can run the application using Docker:
```bash
docker compose up -d
```
## Running Tests
Run the tests using this command
```bash
pytest
```

## Contributing
I welcome contributions to improve the documentation! You can contribute [here](https://github.com/jod35/fastapi-beyond-crud-docs).
