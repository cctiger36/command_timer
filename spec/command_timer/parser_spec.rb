require 'spec_helper'

describe CommandTimer::Parser do
  describe "::parse" do
    let(:commands) { CommandTimer::Parser.parse(sample_commands_config_file) }
    let(:command) { commands.first }

    it "should parse the command config file and return Command objects" do
      commands.size.should == 3
      command.should be_an_instance_of CommandTimer::Command
      command.description.should == "command on schedule"
    end

    it "should parse the burn_time to Time" do
      command.burn_time.should == Time.new(Time.now.year, Time.now.month, Time.now.day, 14, 0, 0)
    end

    it "should concatenate commands in content to single line" do
      command.content.should == "pwd;whoami;"
    end

    it "should parse observer commands if present" do
      command.observer.should == "free;"
      commands[1].observer.should be_nil
    end
  end
end
