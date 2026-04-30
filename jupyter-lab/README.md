# Jupyter Labs
Purpose of this labs is to run python scripts to reduce repitative works and do it efficiently.

## Requirements
- You need to install docker to run this lab.

## Installation
- Create a directory `works` in your project directory, which will contains your excel files etc.
- Create `docker-compose.yaml` with following-
    ```yaml
    services:
      jupyter:
        container_name: jupyter-lab
        image: ghcr.io/tech-thinker/jupyter-lab:<version>
        ports:
          - "8888:3000"
        volumes:
          - ./works:/app/works
        environment:
          JUPYTER_PASSWORD: "<Your-secure-password>"
    ```
- Run using following command-
    ```sh
    docker-compose up -d
    # or
    docker compose up -d
    ```
- Your application will be available on `http://localhost:8888`

## Contribution
To contribute in this projects you need to do following steps.
1. Go to repository `github.com/tech-thinker/jupyter-labs`
2. Create an issue/tickets about your contirubution if not there.
3. Fork this repository.
4. Add your notebook inside `labs` directory.
5. [Optional] In case any dependency you can add to `Dockerfile`. In between two comments.
    ```sh
    # Your custom dependencies start here...
    
    # Your custom dependencies end here...
    ```

6. Git add and commit.
7. Push to your repository.
8. Create pull request and merge it.
9. Create a release with `v*.*.*` formated version tag.
10. After build process finish you can use it.


## Author
- Asif Mohammad Mollah
