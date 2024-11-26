#!/bin/bash

DOCKER_PATH="dendrophone-emulation/docker"

if ! docker images | grep -q cm4-build; then
    sudo docker build -t cm4-build $DOCKER_PATH
fi

if [[ "$1" == "run" ]]; then
    renode dendrophone-emulation/platform/run.resc --console
    exit
fi

if [[ "$1" == "clean" ]]; then
    rm -rf build
fi

sudo docker run --platform linux/arm64 --rm -v $(pwd):/work -w /work cm4-build bash -c "
mkdir -p build &&
cd build &&
cmake .. &&
make"
