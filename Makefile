all: build

build:
	@docker build --tag=crispychrispe/bind9-webmin2 .
