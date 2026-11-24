.PHONY: all help deps update clean

all:
	./build.sh

help:
	@echo "Targets:"
	@echo "help    show this help message"
	@echo "deps    install pybase16-builder"
	@echo "update  clone/pull base16 schemes"
	@echo "all     build themes for all terminals"
	@echo "clean   delete scheme repos"

deps:
	pip3 install pybase16-builder

update:
	./update.sh

clean:
	rm -rf build
