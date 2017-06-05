# -*- mode: ruby -*-
# vi: set ft=ruby :
# vi: set tabstop=2 :
# vi: set shiftwidth=2 :

Vagrant.configure("2") do |config|

	conts = [
		{ :name => "debian7",	:dockerfile => "debian7" },
		{ :name => "debian8",	:dockerfile => "debian8" },
		{ :name => "debian9", :dockerfile => "debian9" }
	]

	conts.each do |opts|
		config.vm.define opts[:name] do |m|
			m.vm.provider "docker" do |d|
				d.image = opts[:image]
				d.build_dir = "."
				d.remains_running = true
				d.has_ssh = true
				d.dockerfile = opts[:dockerfile] + "/Dockerfile"
			end
			m.vm.provision "ansible" do |ansible|
				ansible.playbook = "tests/test.yml"
				ansible.verbose = 'vv'
				ansible.sudo = true
				ansible.extra_vars = opts[:vars]
			end
		end
	end
end
