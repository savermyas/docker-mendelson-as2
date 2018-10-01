include .env

.PHONY : image start

image : image/mendelson-$(MENDELSON_VERSION).zip
	docker build --build-arg MENDELSON_VERSION=$(MENDELSON_VERSION) -t saver/mendelson-as2:$(MENDELSON_VERSION) image

image/mendelson-$(MENDELSON_VERSION).zip :
	curl -L http://downloads.sourceforge.net/project/mec-as2/install_mendelson_opensource_as2_$(MENDELSON_VERSION).zip > $@

start :
	docker-compose up -d
	HTTP_PORT=$$(docker-compose port as2 8080 | cut -d: -f2);\
	echo Use http://localhost:$${HTTP_PORT} to connect to your Mendelson AS2