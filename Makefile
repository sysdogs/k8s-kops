.PHONY: test
test:
	pre-commit run --all-files

dist/clusters/%.yml: values/%.yml test
	kops toolbox template --fail-on-missing \
                      --format-yaml \
                      --template src/eu-west-1/templates \
                      --snippets src/eu-west-1/snippets \
                      --values $< \
                      > $@
	kops replace --force -f $@
	kops update cluster
