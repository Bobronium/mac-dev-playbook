.PHONY: all ansible requirements play

all: play

venv:
	python3 -m venv venv
	venv/bin/pip install -U pip setuptools

ansible: venv
	venv/bin/pip install -U ansible
	touch venv/.ansible-installation

venv/.ansible-installation:
	make ansible

requirements: venv/.ansible-installation
	venv/bin/ansible-galaxy install --force -r requirements.yml
	touch venv/.requirements-installation

venv/.requirements-installation:
	make requirements

play: venv/.requirements-installation
	venv/bin/ansible-playbook main.yml --ask-become-pass
