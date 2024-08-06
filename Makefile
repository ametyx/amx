.PHONY: amx all clean

amx:
	@$(MAKE) -C framework build

sandbox:
	@$(MAKE) -C sandbox build

all: amx sandbox

run:
	@$(MAKE) -C sandbox run

clean:
	@$(MAKE) -C framework clean
	@$(MAKE) -C sandbox clean

clear: clean
	@$(MAKE) -C framework clear
	@$(MAKE) -C sandbox clear