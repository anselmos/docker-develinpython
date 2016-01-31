docker rm -f devel_in_python
docker run \
    -it \
    --name devel_in_python \
    anselmos/devel-in-python $1
