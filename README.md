Mendelson AS2 in the container
==============================

[![Build Status](https://travis-ci.org/savermyas/docker-mendelson-as2.svg?branch=master)](https://travis-ci.org/savermyas/docker-mendelson-as2)

This repo contains everything that you need to run [Mendelson AS2](http://as2.mendelson-e-c.com) in Docker container.


Requirements
------------

* Docker Engine 1.10 or above
* Docker Compose 1.8.1 or above
* GNU make for manual image build


Build
-----

1. Clone the repo, enter the folder.
2. Run the command:

    make

Run
---

You may just skip the build and use image from Docker Hub

1. Run the command:
```
    docker-compose up -d
```
   or
```
    make start
```
2. Look for port mappings with command: 
```
    docker-compose ps
```

3. Use browser and vncviewer with appropriate ports and password from files `image/custom/vncpasswd` and `image/custom/webpasswd`, watch logs in `wd` folder


Links
-----

* [Docker Hub link](https://hub.docker.com/r/saver/mendelson-as2/)
