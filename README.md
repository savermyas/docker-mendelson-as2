Mendelson AS2 in the container
==============================

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

    make image

Run
---

You may just skip the build and use image from Docker Hub

1. Edit passwords files in the directory "image/custom/"
2. Run the command:

    docker-compose up

3. Look for port mappings with command: 

    docker ps -l

or 

    docker inspect as2

4. Use browser and vncviewer with appropriate ports and password from step 2, watch logs in wd folder


Links
-----

* [Docker Hub link](https://hub.docker.com/r/saver/as2/)
