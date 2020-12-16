# Experiments environment
A basic environment to enable AI experiments on remote machines.

## Usage

Configure your ssh keys in the compute engine, these two links may help:

- https://cloud.google.com/compute/docs/instances/adding-removing-ssh-keys#createsshkeys

- https://souvikhaldar.medium.com/how-to-add-the-public-ssh-key-to-a-gcp-virtual-machine-ef5703e8e596

After configuring your ssh-keys, SSH into the vm with something like this:
```
ssh -i ssh_private_key_file ssh_user@vm_ip_address
```

### Run docker

Any of the docker scripts creates a shared volume in `/workspace/data`, so that's where you'll want to put your custom data and code.

#### docker-compose

This option does not enable GPU, but creates a volume and exposes the 8890 port.

To expose the ports defined within the docker-compose when using 'run' enable the --service-ports flag:
```
docker-compose run --service-ports experiments
```

#### docker run

This option enables GPU, creates a volume, increases shared volume and exposes the 8890 port.
```
./run_gpu.sh image_name command
```

### Connect to Jupyter Lab environment

On the local machine, tunnel the exposed vm's port to a local one:
```
ssh -N -L 8890:127.0.0.1:8890 ssh_user@vm_ip_address
```

Then initiate the jupyter lab instance in the docker environment with the following line (or with run_jupyter.sh):
```
jupyter lab --ip 0.0.0.0 --port 8890 --allow-root --no-browser
```

Then access the jupyter lab environment on the local machine with the url that appears on screen or with:
```
http://127.0.0.1:8890/lab
```

## References

- Dataloader in docker shared memory issue: https://github.com/pytorch/pytorch/issues/8976#issuecomment-481442240
