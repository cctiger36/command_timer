require 'spec_helper'

describe CommandTimer::Runner do
  it "should echo all commands when initialized" do
    output = capture_stdout { CommandTimer::Runner.new(sample_commands_config_file) }
    output.should include "Command 1"
    output.should include "Command 2"
    output.should include "Command 3"
  end

  context "run commands" do
  end
end
