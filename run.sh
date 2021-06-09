#!/bin/bash

# Create the namespace to setup the project
createNS() {
    kubectl create ns sd-exam3
}

# Select the correct namespace to be sure
Set-Context() {
    kubectl config set-context --current --namespace=sd-exam3    
}

# launch the deployments and services required for the DB
# in the sd-exam3 namespace
deployDB() {
    Set-Context
    kubectl apply -f ./database/deployments
    kubectl apply -f ./database/services
}

# launch the deployment and service required for the APP
# in the sd-exam3 namespace
deployApp() {
    Set-Context
    kubectl apply -f './app-deployment'
}

# launch all in the sd-exam3 namespace
deploy() {
    deployDB
    deployApp
}

# halt the deployments and services required for the DB
# in the sd-exam3 namespace
haltDB() {
    Set-Context
    kubectl delete -f ./database/deployments
    kubectl delete -f ./database/services
}

# halt the deployment and service required for the APP
# in the sd-exam3 namespace
haltApp() {
    Set-Context
    kubectl delete -f ./app-deployment
}

# halt all in the sd-exam3 namespace
halt() {
    haltDB
    haltApp
}

buildApp() {
    docker rmi franjaresc/sd-exam3
    docker build -t franjaresc/sd-exam3 ./app 
}

pushApp() {
    docker push franjaresc/sd-exam3
}

reloadChanges() {
    Set-Context
    haltApp
    buildApp
    pushApp
    deployApp
}

for arg in "$@"
do
    eval $arg
done