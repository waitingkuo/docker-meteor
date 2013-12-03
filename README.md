docker-meteor
=============

A deploy tool for meteor based on docker 

## Usage

  `deploy` is a tool to deploy the bundle of a meteor app to any host which has installed docker

  `stop` is a tool to terminate the meteor server 

## Example

    # init test environment
    vagrant up
    cat ~/.ssh/id_dsa.pub | ssh vagrant@192.168.66.66 'cat >> .ssh/authorized_keys'

    # make the bundle of meteor app
    cd meteor
    meteor bundle bundle.tar.gz
    cd ..

    # deploy
    ./deploy vagrant@192.168.66.66 app1 bundle.tar.gz

    # check whether it runs successfully
    curl 192.168.66.66

    # stop it
    ./stop vagrant@192.168.66.66 app1
