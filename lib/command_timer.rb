require "command_timer/version"
require "command_timer/command"
require "command_timer/runner"
require "command_timer/parser"

module CommandTimer
  def self.run(yml)
    Runner.new.start(yml)
  end
end
