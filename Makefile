SHELL = /bin/bash

SRCDIR = Sources
SOURCES = $(wildcard $(SRCDIR)/**/*.swift)

PACKAGEDIR = $(shell pwd)

BUILDDIR = $(PACKAGEDIR)/.build
BUILD = $(BUILDDIR)/release/cookie-cleaner
OUT = $(HOME)/.bin/cookie-cleaner

$(OUT): $(BUILD)
	@mkdir -p $(shell dirname $(OUT))
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
