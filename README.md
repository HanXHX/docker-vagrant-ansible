Docker Vagrant Ansible
======================

[![Build Status](https://travis-ci.org/HanXHX/docker-vagrant-ansible.svg?branch=master)](https://travis-ci.org/HanXHX/docker-vagrant-ansible)

Provides docker containers for Vagrant + Ansible.

Supported OS
------------

* Debian 7 (Wheezy) : `docker pull hanxhx/vagrant-ansible:debian7`
* Debian 8 (Jessie) : `docker pull hanxhx/vagrant-ansible:debian8`
* Debian 9 (Stretch) : `docker pull hanxhx/vagrant-ansible:debian9`
* Ubuntu 16.04 (Xenial) : `docker pull hanxhx/vagrant-ansible:ubuntu16.04`
* Ubuntu 18.04 (Bionic) : `docker pull hanxhx/vagrant-ansible:ubuntu18.04`

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
env:
  - PLATFORM='docker-debian9'

sudo: required

dist: trusty

services:
  - docker

language: python

before_install:
  - wget https://releases.hashicorp.com/vagrant/2.0.1/vagrant_2.0.1_x86_64.deb
  - sudo dpkg -i vagrant_2.0.1_x86_64.deb

install:
  - pip install ansible

script:
  - VAGRANT_DEFAULT_PROVIDER=docker vagrant up
  - >
    VAGRANT_DEFAULT_PROVIDER=docker vagrant provision $PLATFORM
    | grep -q 'changed=0.*failed=0'
    && (echo 'Idempotence test: pass' && exit 0)
    || (echo 'Idempotence test: fail' && exit 1)
  - VAGRANT_DEFAULT_PROVIDER=docker vagrant status
```
