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

#
# Targets
#
default: $(CLUSTER_FILES)

clean:
	rm -rf $(CLUSTER_FILES)
