# cus_jup

This is my customized jupyter lab container files, used to inject the needful configuration to build a suitable docker instance for doing data analytic task on the go! 

### What is Inside?
 - Latest Version fo [Anaconda python 3](https://docs.anaconda.com/anaconda/)
 - [jupyterthemes](https://github.com/dunovank/jupyter-themes)
 - [pymssql](https://pypi.org/project/pymssql/)
 - [quilt](https://quiltdata.com/)
 - [missingno](https://github.com/ResidentMario/missingno)
 - [json_tricks](https://github.com/mverleg/pyjson_tricks)
 - [elasticsearch](https://pypi.org/project/elasticsearch/)
 - [jupyter_contrib_nbextensions](https://github.com/ipython-contrib/jupyter_contrib_nbextensions)
 - [jupyter_nbextensions_configurator](https://github.com/Jupyter-contrib/jupyter_nbextensions_configurator)

### Installation
Any changes to the Dockerfile will be automatically built-in Docker Hub, so just pull the container:

`docker pull alifazeli/cus_jup`

### Run
 Run the container in a detached mode so that you can use Jupyter Notebooks but still use bash:
1. <b>Linux</b>:
     `docker run -d --name custom_jupyter -v ~/my_project:/root/my_project --network=host -i alifazeli/cus_jup` <br>
     `docker exec -it custom_jupyter  bash` 
2.<b>Windows</b>:
     `docker run -d--name custom_jupyter -v ${pwd}:/root/myproject  -p 8888:8888 -i alifazeli/cus_jup `<br>
     `docker exec -it custom_jupyter  bash` 
3.<b>MacOS</b>:
    `docker run -d--name custom_jupyter -v ~/my_project:/root/myproject  -p 8888:8888 -i alifazeli/cus_jup `<br>
    `docker exec -it custom_jupyter  bash` 

To use Jupyter Lab on your host machine, just navigate to `localhost:8888` and enter the token `my_custom_jupyter`.

### Changing the Configurations

This DockerFile is meant to fetch my personalized configurations and settings for jupyter lab and jupyterthemes extension.<br> but you can easily customize it using a bash terminal and `jt` command. if you're not familiar with jupyterthems, refer to their GitHub page. 
