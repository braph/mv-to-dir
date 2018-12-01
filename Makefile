PREFIX = /usr

PROGRAM = mv-to-dir

install:
	install -m 0755 $(PROGRAM).sh $(PREFIX)/bin/$(PROGRAM)
