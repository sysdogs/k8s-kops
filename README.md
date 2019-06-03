## k8s-kops

This is a templated version of `k8s`, `kops`-based cluster.

## Purpose

The main purposes of this repository:
  - Provide a repository to manage multiple Kubernetes clusters with `kops`.
  - Keep Kubernetes clusters _Configuration as Code_.
  - Have an easy way to change Kubernetes cluster's parameters.
  - Have a templated version of Kubernetes cluster deployed on Amazon Web Services.
  - Provide a Kubernetes cluster with basic security policies applied.
  - Automate workflow with `kops`.


## Usage

First of all, `kops` must be installed. [[kops-installation]]
Then, you can use the templated version of the cluster.
Have fun.


* Export `KOPS_STATE_STORE` environment variable:
```
export KOPS_STATE_STORE="s3://exampleenv-kops-s3
```
You *always* have to set this environment variable.


#### Automated installation

  - It is possible to use `Makefile` target, for example:

  ```
  make dist/clusters/cluster-exampleenv.yml
  ```
  Notice that this target assumes equality of `<cluster-name>`
  between `dist/clusters/<cluster-name>.yml` and `values/<cluster-name>.yml`




##### Manual installation

* Create a template from values:
```
kops toolbox template --fail-on-missing \
                      --format-yaml \
                      --template src/eu-west-1/templates \
                      --snippets src/eu-west-1/snippets \
                      --values values/cluster-exampleenv.yml \
                      > dist/clusters/cluster-exampleenv.yml
```

* Generate a cluster from template:
```
kops create -f clusters/cluster-exampleenv.yml
```


## Contribution

Make sure all tests passes from the following target:

```
make test
```

Its requirement is `pre-commit`.




[kops-installation]: https://github.com/kubernetes/kops#installing
