# Create the namespace to setup the project
function createNS {
    kubectl create ns sd-exam3
}

# Select the correct namespace to be sure
function Set-Context {
    kubectl config set-context --current --namespace=sd-exam3    
}

# launch the deployments and services required for the DB
# in the sd-exam3 namespace
function deployDB {
    Set-Context
    kubectl apply -f ./database/deployments
    kubectl apply -f ./database/services
}

# launch the deployment and service required for the APP
# in the sd-exam3 namespace
function deployApp {
    Set-Context
    kubectl apply -f './app-deployment'
}

# launch all in the sd-exam3 namespace
function deploy {
    deployDB
    deployApp
}

# halt the deployments and services required for the DB
# in the sd-exam3 namespace
function haltDB {
    Set-Context
    kubectl delete -f ./database/deployments
    kubectl delete -f ./database/services
}

# halt the deployment and service required for the APP
# in the sd-exam3 namespace
function haltApp {
    Set-Context
    kubectl delete -f ./app-deployment
}

# halt all in the sd-exam3 namespace
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