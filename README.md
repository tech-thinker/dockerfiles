# dockerfiles
This is the repository for version locked docker files.

## Adding new image:
1. Create a directory named as "image_name" that you want to create.
2. Create a Dockerfile named as `Dockerfile` in the directory.
3. Create a `.arch` file in the directory that contains the architecture of the image. As bellow-
```sh
amd64,arm64
```
4. Create a `.version` file in the directory that contains the version of the image. As bellow-
```sh
v0.0.1-alpha
```
5. Create a `.forced` file in the directory that contains the forced build tag.
6. Create a docker-compose file named as `docker-compose.yml` in the directory.
7. Create a `README.md` file in the directory that contains the description of the image.
8. Create a pull request.
