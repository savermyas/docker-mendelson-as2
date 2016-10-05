Mendelson AS2 in the container
==============================

This repo contains everything that you need to run Mendelson AS in Docker container.


Requirements
------------

   * Docker Engine 1.10 or above
   * Docker Compose 1.8.1 or above


Instructions
------------

   1. Clone the repo, enter the folder.
   2. Edit passwords files in the directory "image/custom/"
   3. Run the command:

    docker-compose up

   4. Look for port mappings with command: 

    docker ps -l

      or 

    docker inspect as2

   5. Use browser and vncviewer with appropriate ports, watch logs in wd folder


Links
-----

   * [Docker Hub link](https://hub.docker.com/r/saver/as2/)
