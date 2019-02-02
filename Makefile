# 
# Variables
#
VALUE_FILES   = $(wildcard values/*.yml)
CLUSTER_FILES = $(patsubst values/%,dist/clusters/%,$(VALUE_FILES))

#
# Rules
#
dist/clusters/%.yml: values/%.yml
	kops toolbox template --fail-on-missing \
                      --format-yaml \
                      --template src/eu-west-1/templates \
                      --snippets src/eu-west-1/snippets \
                      --values $< \
                      > $@
	kops replace --force -f $@ --name $(patsubst dist/clusters/%.yml,%,$@)
	kops update cluster --name $(patsubst dist/clusters/%.yml,%,$@)

#
# Targets
#
.PHONY: update test clean

update: $(CLUSTER_FILES)

test:
	pre-commit run --all-files

clean:
	rm -rf $(CLUSTER_FILES)
