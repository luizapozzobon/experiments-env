docker run --gpus all --shm-size=16g -p 8890:8890 -v $(pwd)/data/:/workspace/data -it $1 $2
