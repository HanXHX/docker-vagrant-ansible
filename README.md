Docker Vagrant Ansible
======================

[![Docker Hub](https://img.shields.io/badge/Docker%20Hub-hanxhx%2Fvagrant--ansible-2496ed?logo=docker)](https://hub.docker.com/r/hanxhx/vagrant-ansible) [![Build Status](https://app.travis-ci.com/HanXHX/docker-vagrant-ansible.svg?branch=master)](https://app.travis-ci.com/HanXHX/docker-vagrant-ansible)

Provides docker containers for Vagrant + Ansible.

Supported OS
------------

* Debian 8 (Jessie) : `docker pull hanxhx/vagrant-ansible:debian8`
* Debian 9 (Stretch) : `docker pull hanxhx/vagrant-ansible:debian9`
* Debian 10 (Buster) : `docker pull hanxhx/vagrant-ansible:debian10`
* Debian 11 (Bullseye) : `docker pull hanxhx/vagrant-ansible:debian11`
* Ubuntu 16.04 (Xenial) : `docker pull hanxhx/vagrant-ansible:ubuntu16.04`
* Ubuntu 18.04 (Bionic) : `docker pull hanxhx/vagrant-ansible:ubuntu18.04`
* Ubuntu 20.04 (Bionic) : `docker pull hanxhx/vagrant-ansible:ubuntu20.04`

Vagrantfile example
-------------------

```ruby
Vagrant.configure("2") do |config|
  config.vm.define "docker-debian9" do |m|
    m.vm.provider "docker" do |d|
      d.image = "hanxhx/vagrant-ansible:debian9"
      d.remains_running = true
      d.has_ssh = true
    end
    m.vm.provision "ansible" do |ansible|
      ansible.playbook = "tests/test.yml"
    end
  end
end
```

Travis-CI example
-----------------

```yaml
---

env:
  global:
    - VAGRANT_VERSION='2.2.18'
  jobs:
    - PLATFORM='docker-debian9' ANSIBLE_VERSION='>=2.11,<2.12'

os:
  - linux
dist: focal

language: python
python:
  - 3.8

services:
  - docker

before_install:
  - sudo apt-get -q update
  - sudo wget -nv https://releases.hashicorp.com/vagrant/${VAGRANT_VERSION}/vagrant_${VAGRANT_VERSION}_x86_64.deb

install:
  - sudo dpkg -i vagrant_${VAGRANT_VERSION}_x86_64.deb
  - sudo pip install "ansible-core${ANSIBLE_VERSION}"

script:
  - vagrant up $PLATFORM
  - >
    vagrant provision $PLATFORM
    | grep -q 'changed=0.*failed=0'
    && (echo 'Idempotence test: pass' && exit 0)
    || (echo 'Idempotence test: fail' && exit 1)
  - vagrant status
```
