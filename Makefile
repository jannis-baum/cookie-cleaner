SHELL = /bin/bash

srcdir = Sources

REPODIR = $(shell pwd)
BUILDDIR = $(REPODIR)/.build
BUILD = $(BUILDDIR)/release/cookie-cleaner
OUT = $(HOME)/.bin/cookie-cleaner
SOURCES = $(wildcard $(srcdir)/**/*.swift)

$(OUT): $(BUILD)
	@mkdir -p $(dirname) $(OUT)
	@cp $(BUILD) $(OUT)

$(BUILD): $(SOURCES)
	@swift build \
		-c release \
		--disable-sandbox \
		--build-path "$(BUILDDIR)" \
		-Xswiftc "-target" \
		-Xswiftc "x86_64-apple-macosx10.11"

.PHONY: clean
clean:
	@rm -rf $(BUILDDIR)
