include .env

DOWNLOAD_BASE_URL=https://downloads.sourceforge.net/project/mec-as2
DOWNLOAD_FILE=install_mendelson_opensource_as2_$(MENDELSON_VERSION).zip
DOWNLOAD_PARAMS=ts=$(shell date +%s)
DOWNLOAD_URL=$(DOWNLOAD_BASE_URL)/$(DOWNLOAD_FILE)?$(DOWNLOAD_PARAMS)

.PHONY : image start

image : image/mendelson-$(MENDELSON_VERSION).zip
	docker build \
	--build-arg MENDELSON_VERSION=$(MENDELSON_VERSION) \
	--build-arg JAVA_VERSION=$(JAVA_VERSION) \
	-t saver/mendelson-as2:$(MENDELSON_VERSION) \
	image

image/mendelson-$(MENDELSON_VERSION).zip :
	curl -L $(DOWNLOAD_URL) --output $@

start :
	docker-compose up -d
	HTTP_PORT=$$(docker-compose port as2 8080 | cut -d: -f2);\
	echo Use http://localhost:$${HTTP_PORT} to connect to your Mendelson AS2
