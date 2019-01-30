.PHONY: clean

dist/clusters/%.yml: values/%.yml
	kops toolbox template --fail-on-missing \
                      --format-yaml \
                      --template src/eu-west-1/templates \
                      --snippets src/eu-west-1/snippets \
                      --values $< \
                      > $@

cluster_specs: dist/clusters/cluster-exampleenv.yml

clean:
	rm -f dist/clusters/cluster-exampleenv.yml

