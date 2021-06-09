function createNS {
    kubectl create ns sd-exam3
}

function Set-Context {
    kubectl config set-context --current --namespace=sd-exam3    
}

function deployDB {
    Set-Context
    kubectl apply -f ./database/deployments
    kubectl apply -f ./database/services
}

function deployApp {
    Set-Context
    kubectl apply -f './app-deployment'
}

function deployLocal {
    deployDB
    deployApp
}

function haltDB {
    Set-Context
    kubectl delete -f ./database/deployments
    kubectl delete -f ./database/services
}

function haltApp {
    Set-Context
    kubectl delete -f ./app-deployment
}

function halt {
    haltDB
    haltApp
}

function buildApp {
    docker rmi franjaresc/sd-exam3
    docker build -t franjaresc/sd-exam3 ./app 
}

function pushApp {
    docker push franjaresc/sd-exam3
}

function reloadChanges {
    Set-Context
    haltApp
    buildApp
    pushApp
    deployApp
}

foreach ($arg in $args) {
    invoke-expression $arg
}