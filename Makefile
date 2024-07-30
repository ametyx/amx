CACHEDIR = .zig-cache
OUTDIR = zig-out
TARGET = amx

all:
	@zig build

run:
	@zig build run

test:
	@zig build test

.PHONY: clean

clean:
	@rmdir /s /q $(OUTDIR)

clear: clean
	@rmdir /s /q $(CACHEDIR)