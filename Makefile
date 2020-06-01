.PHONY: release changelog

SEMTAG=.tools/semtag
CHANGELOG_FILE=CHANGELOG.md

scope ?= "minor"

changelog:
	git-chglog -o $(CHANGELOG_FILE) --next-tag `$(SEMTAG) final -s $(scope) -o -f`

release:
	$(SEMTAG) final -s $(scope)
