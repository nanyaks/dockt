# dockt
Simple docker control

**Docker** control made simple. Really :)

## What is this all about?
Well, as an introduction, dockt - or dockt for short, is a simple tool with the life purpose of making docker control a bit easier. It aims to reduce the barrier to entry for docker and the docker suite for developers at Delivery Science.  
What we've seen from experience is that a huge amount of time is spent by developers trying to get the hang of docker and how to use it for development at DS.  
Hope this helps.  

## Install
Installing dockt really is simple. Right now, all that needs to be done is move the script to your path.  

```
chmod +x dockt.sh
mv dockt.sh /usr/local/bin
```
With this, you should be able to run this simply as **dockt** without the `.sh` in there.  
I've noted the need for an install script for the project. If you'll like to help out, be my guest. It might be a while before I get to it because I think I have important features for dockt which in my humble opinion, are priority.

## features
#### stop-all
Stop all docker containers currently running.  

~~~shell
dockt stop-all
~~~
This is shorthand for:  

```
docker stop $(docker ps -aq)
``` 

#### remove-all
Stop and remove all running containers  

~~~shell
dockt remove-all
~~~  
This is shorthand for:  

~~~
docker stop $(docker ps -aq) && docker stop $(docker ps -aq)
~~~

#### start
To start a docker-machine environment, you could use:  

~~~shell
dockt start dev
~~~  
assuming *dev* is the name of the docker machine environment you'd want to start up.  

#### stop
Stop the docker-machine *dev*  

~~~shell
dockt stop dev
~~~  

#### status
Get the status of the docker-machine  

~~~sh
dockt status
~~~  

### todo
* `compose up`
* `compose stop`
* `compose status`
* `compose ps`
* `show all`
* `show`
* `dockt enable dev` to replace `eval "$(docker-machine env dev)"`