IMAGE_NAME=zfkun/amd64-pve-godns
GODNS_VERSION=3.3.3
GODNS_REPO=https://ghfast.top/https://github.com/TimothyYe/godns

# build latest
docker build --network host --build-arg GODNS_VERSION=$GODNS_VERSION --build-arg GODNS_REPO=$GODNS_REPO -t $IMAGE_NAME:latest

# build specific version
docker tag $IMAGE_NAME:latest $IMAGE_NAME:$GODNS_VERSION