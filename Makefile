MENDELSON_AS2_VERSION = 1.1b51

.PHONY : image

image :
	docker build image -t saver/mendelson-as2:$(MENDELSON_AS2_VERSION)
