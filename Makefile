all: build

build:
	@docker build --tag=edwardchen/bindwebmin .
