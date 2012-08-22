# CommandTimer

Simple tool to execute commands on schedule. Designed for maintain web applications.

## Installation

    $ gem install command_timer

## Usage

    $ cmdtimer command_config_file

## Command Config File Sample (YAML)

    command1:
        description: "stop unicorn"
		burn_time: "14:00:00"
		content: |
			cd /path/to/app/
			cap unicorn:stop
	command2:
		desciption: "deploy"
		burn_time:
		content: |
			cd /path/to/app/
			cap deploy
		observer: |
			cd /path/to/app/
			cap invoke COMMAND="tail -f /path/to/log/file"

* burn_time: 
	1. HH:mm:ss - execute commands on time.
	2. blank - execute commands by user input.
	3. auto - execute commands after previous command ended.
