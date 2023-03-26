#!/usr/bin/env bash

# clean up
kubectl delete pod webapp-pod
docker stop webapp
docker rm webapp
docker rmi newtonsarker/webapp:1.0

# build app
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk use java 17.0.6-tem
java --version
./gradlew clean build installDist

# build image
docker login -u "newtonsarker" docker.io
docker image build -t newtonsarker/webapp:1.0 .
docker image push newtonsarker/webapp:1.0
# docker run -d -p 8080:8080 --name webapp newtonsarker/webapp:1.0
# docker run -it --name webapp newtonsarker/webapp:1.0 /bin/bash
# sleep 3
# curl http://localhost:8080/status

# host on k8s
kubectl apply -f pod.yml
# kubectl get pods --watch
# kubectl get pods -o wide
# kubectl describe pods webapp-pod
# kubectl delete pod webapp-pod