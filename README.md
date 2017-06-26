# elixir-emacs
Based on the official elixir container. 
Adds postgres, node for phoenix framework & emacs.

*Note*

To persist postgres data on host,

1. First run the image overriding CMD with /bin/bash
2. Inside the container, drop and create new cluster. This creates the necessary directories on the mounted host directory. (See Dockerfile for instructions)
3. Exit and run the image with the command below.

*In .bash_alias*
```
alias elixir='docker run --name elixir -it --rm -p 80:4000 -v $HOME/workspace/elixir:/root -v $HOME/workspace/postgres/:/var/lib/postgresql sundernarayanaswamy/elixir-dev-docker'
```


