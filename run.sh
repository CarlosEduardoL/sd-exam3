#!/bin/bash

createNS() {
    kubectl create ns sd-exam3
}

Set-Context() {
    kubectl config set-context --current --namespace=sd-exam3    
}

deployDB() {
    Set-Context
    kubectl apply -f ./database/deployments
    kubectl apply -f ./database/services
}

deployApp() {
    Set-Context
    kubectl apply -f './app-deployment'
}

deployLocal() {
    deployDB
    deployApp
}

haltDB() {
    Set-Context
    kubectl delete -f ./database/deployments
    kubectl delete -f ./database/services
}

haltApp() {
    Set-Context
    kubectl delete -f ./app-deployment
}

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