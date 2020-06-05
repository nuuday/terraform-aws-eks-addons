.PHONY: release changelog

SEMTAG=.tools/semtag
CHANGELOG_FILE=CHANGELOG.md
ADDON_DIR=modules
BUILD_PWSH=.tools/build.ps1

scope ?= "minor"

changelog:
	git-chglog -o $(CHANGELOG_FILE) --next-tag `$(SEMTAG) final -s $(scope) -o -f`

release:
	$(SEMTAG) final -s $(scope)

show-next-version:
	@$(SEMTAG) final -s $(scope) -o -f

build-main-pwsh:
	 pwsh $(BUILD_PWSH) -ModulesPath $(ADDON_DIR) -MainPath .\main.tf -VariablesPath .\auto-variables.tf -OutputsPath .\auto-outputs.tf