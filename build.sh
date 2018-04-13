#!/bin/bash
export VTN_BUILD_TAG=2016.11.15
rm -f oadr2b-vtn-0.9.3.production-${VTN_BUILD_TAG}.tar.gz
tar --exclude='*.log' --exclude='mysql/*' --exclude='*.gz' --exclude='.git/*' --exclude='tmp/*' --exclude='Dockerfile' -cvf oadr2b-vtn-0.9.3.production-${VTN_BUILD_TAG}.tar .
gzip -f oadr2b-vtn-0.9.3.production-${VTN_BUILD_TAG}.tar
docker build --build-arg VTN_BUILD_TAG=${VTN_BUILD_TAG} -t openadr/oadr2b-vtn:${VTN_BUILD_TAG} .

