# Kollegorna asdf Docker Image

This docker image(s) are used in our development environments. We use [asdf](https://asdf-vm.com/) to be able to switch node/yarn versions with ease.

## Ruby images

Ruby doesn't provide a good way of just downloading an executable like how NodeJS does it. So we have several images with different ruby versions that have Ruby pre-compiled.

A new project **should always** use the latest Rails-supported version.

### Versions

Currently supported versions:

* 2.4.9 (end of life march 2020)
* 2.6.4
* 2.6.5
* 2.6.6
* 2.7.1