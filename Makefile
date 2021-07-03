SHELL = /bin/bash

srcdir = Sources

REPODIR = $(shell pwd)
BUILDDIR = $(REPODIR)/.build
SOURCES = $(wildcard $(srcdir)/**/*.swift)

.DEFAULT_GOAL = all

.PHONY: all
all: clearcookies

clearcookies: $(SOURCES)
	@swift build \
		-c release \
		--disable-sandbox \
		--build-path "$(BUILDDIR)" \
		-Xswiftc "-target" \
		-Xswiftc "x86_64-apple-macosx10.11"

.PHONY: clean
clean:
	@rm -r $(BUILDDIR)

