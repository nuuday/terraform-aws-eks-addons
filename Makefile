.PHONY: release changelog

SEMTAG=.tools/semtag
CHANGELOG_FILE=CHANGELOG.md

scope ?= "minor"

changelog:
	git-chglog -o $(CHANGELOG_FILE) --next-tag `$(SEMTAG) final -s $(scope) -o -f`

release:
	$(SEMTAG) final -s $(scope)

show-next-version:
	@$(SEMTAG) final -s $(scope) -o -f



##
# New release procedure using an public s3 bucket for package storage
#
# Basically this builds each module containing the metadata file `module.yaml` if the CHANGES variable is given
# it filters out all changed modules and only builds those. for this to work with ci a list of changed files include
# a commit or be provided via the CHANGE variable
##
MODULE_PATH         ?= modules
# DISTRIBUTION        ?= s3 path

override module_info = module.yaml
override module_list = $(patsubst $(MODULE_PATH)/%/$(module_info),%,$(wildcard $(MODULE_PATH)/*/$(module_info)))
ifndef CHANGES
override modules     = $(module_list)
else
override modules     = $(filter $(foreach change,$(CHANGES), $(call module-changed,$(change))), $(module_list))
endif
override module_packages = $(patsubst %,package-%,$(modules))


define module-version
$(shell cat $(MODULE_PATH)/$(1)/$(module_info) | grep 'version' | awk '{ printf "%s", $$2 }')
endef

define module-changed
$(shell echo "$(patsubst $(MODULE_PATH)/%,%,$(1))" | awk -F/ '{ printf "%s", $$1 }')
endef

.DEFAULT_GOAL := dist
.PHONY: dist publish
dist: $(module_packages)

publish: dist
	aws s3 cp --acl public-read . --include "*.tar.gz" $(DISTRIBUTION)

# We don't really care about the target name matching the target archive, we will always build the archive if it is
# present in the module list.
package-%: $(MODULE_PATH)/%
	tar --directory=$< -czf $*-$(call module-version,$*).tar.gz .
