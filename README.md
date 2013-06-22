# CommandTimer

Simple tool to execute commands on schedule. Designed for maintain web applications.

## Installation

    $ gem install command_timer

## Usage

    $ cmdtimer [options] COMMANDS_CONFIG_FILE

### Options

<table>
  <tr><td>-c, --count-down</td><td>Assign the seconds to count down. (default 30s)</td></tr>
  <tr><td>-s, --ntp-server</td><td>Assign the NTP server. (only ntp installed)</td></tr>
</table>

## Config File Sample (YAML)

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
    command3:
        description: "start unicorn"
		burn_time: "16:00:00"
		content: |
			cd /path/to/app/
			cap unicorn:start

### burn_time

<table>
  <tr><td>HH:mm:ss</td><td>execute commands on time</td></tr>
  <tr><td>blank</td><td>execute commands by user input</td></tr>
  <tr><td>auto</td><td>execute commands after previous command ended</td></tr>
</table>
