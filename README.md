Docker Vagrant Ansible
======================

[![Build Status](https://travis-ci.org/HanXHX/docker-vagrant-ansible.svg?branch=master)](https://travis-ci.org/HanXHX/docker-vagrant-ansible)

Provides docker containers for Vagrant.

Supported OS
------------

* Debian 7 (Wheezy) : `docker pull hanxhx/vagrant-ansible:debian7`
* Debian 8 (Jessie) : `docker pull hanxhx/vagrant-ansible:debian8`
* Debian 9 (Strech) : `docker pull hanxhx/vagrant-ansible:debian9`

Vagrantfile example
-------------------

```ruby
Vagrant.configure("2") do |config|
  config.vm.define "debian9" do |m|
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
sudo: required

dist: trusty

services:
  - docker

language: python

addons:
  apt:
    packages:
      - build-essential
      - python-dev
      - libffi-dev
      - libssl-dev

before_install:
  - wget https://releases.hashicorp.com/vagrant/1.9.5/vagrant_1.9.5_x86_64.deb
  - sudo dpkg -i vagrant_1.9.5_x86_64.deb

install:
  - pip install ansible

script:
  - vagrant up
  - >
    vagrant provision $PLATFORM
    | grep -q 'changed=0.*failed=0'
    && (echo 'Idempotence test: pass' && exit 0)
    || (echo 'Idempotence test: fail' && exit 1)
  - vagrant status
```
