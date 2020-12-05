# Experiments environment
A basic environment to enable AI experiments on remote machines.

## Usage

After configuring your ssh-keys into the compute engine, SSH into the vm with something like this:
```
ssh -i ssh_private_key_file ssh_user@vm_ip_address
```

To expose the ports defined within the docker-compose when using 'run' enable the --service-ports flag:
```
docker-compose run --service-ports experiments
```

On local machine, tunnel the exposed vm's port to a local one:
```
ssh -N -L 8888:127.0.0.1:8888 ssh_user@vm_ip_address
```

Then initiate the jupyter lab instance in the docker environment with the following line (or with run_jupyter.sh):
```
jupyter lab --ip 0.0.0.0 --port 8888 --allow-root
```

Then access the jupyter lab environment on the local machine with:
```
http://127.0.0.1:8888/lab
```

The docker-compose creates a shared volume in `/workspace/data`, so that's where you'll want to put your custom data and code.

