# Distributed Systems Exam 3 📓

## Developers 👨🏻‍💻👩🏻‍💻
### - 🐱‍💻 Carlos Eduardo Lizalda Valencia.
### - 🐱‍👤 Fransisco Javier Restrepo.
### - 🐱‍👓 Paola Andrea Veloza.
### - 🐱‍🚀 Melqui Jair Aguirre.

## Documentation 📔:
### Can a junior developer get this running?

We need install the next tools 🧰:
- **Docker 🐳** (Docker Desktop on windows)
  - optional if only wants to deploy and not to develop
  - for develoment is required that the user has permission to use the docker binary
- **kubernetes ☸** local cluster (microk8s or minukube)
  - if you are in windows can use docker desktop
  - you can use a cloud cluster instead
- **kubectl 💻**
  - the binary needs to be in the path or in the place of call of the run.[sh | ps1] script
- **Lens 🛠** (optional)
- **Bash 💪🏻**
  - Only for unix like systems

thats works on the follow platforms:
- Windows
- Linux and Unix like system

### the firs time on a new cluster you ned to create the namespace for the deployment 
#### On Windows
```Powershell
./run.ps1 createNS 
```
#### On linux and unix like systems with bash
```bash
./run.sh createNS
```
<br></br>

### Deploy instructions 🚀
to deploy DB services and deployments use the **deployDB** parameter and to deploy the App service and deployment you can use the **deployApp** param

#### On Windows
```Powershell
./run.ps1 deployDB deployApp
```
#### On linux and unix like systems with bash
```bash
./run.sh deployDB deployApp
```

you can only use deploy if you want to do both at time
#### On Windows
```Powershell
./run.ps1 deploy
```
#### On linux and unix like systems with bash
```bash
./run.sh deploy
```
<br></br>

### Developer isntructions 👨🏻‍💻👩🏻‍💻
you can build the image using the parameter **buildApp**
#### On Windows
```Powershell
./run.ps1 build
```
#### On linux and unix like systems with bash
```bash
./run.sh build
```
if the developer have permission can push the image to the repository using the **pushApp** parameter
#### On Windows
```Powershell
./run.ps1 pushApp
```
#### On linux and unix like systems with bash
```bash
./run.sh pushApp
```
for simplicity yu can only call the script with the **reloadChanges** parameter to recreate the iamge and app deployment
#### On Windows
```Powershell
./run.ps1 reloadChanges
```
#### On linux and unix like systems with bash
```bash
./run.sh reloadChanges
```
<br></br>

### Stop the App 🛑
To Stop the DB deployment and services you can use **haltDB** parameter
```Powershell
./run.ps1 haltDB
```
#### On linux and unix like systems with bash
```bash
./run.sh haltDB
```
To Stop the App deployment and services you can use **haltApp** parameter
```Powershell
./run.ps1 haltApp
```
#### On linux and unix like systems with bash
```bash
./run.sh haltApp
```
To Stop everything you can use **halt**
```Powershell
./run.ps1 halt
```
#### On linux and unix like systems with bash
```bash
./run.sh halt
```

### Sugestion
the run script eval the arguments as scrips, all the arguments are internal functions on the script, yo can for example source the script to the current shell to have the arguments as toplevel functions or do things like this
```Powershell
./run.ps1 "deploy; sleep 86400; halt"
```
#### On linux and unix like systems with bash
```bash
./run.sh "deploy && sleep 1d && halt" &
```
deploy all, wait 1 day and halt all.