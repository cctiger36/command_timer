require 'spec_helper'

describe CommandTimer::Runner do
  it "should echo all commands when initialized" do
    output = capture_stdout { CommandTimer::Runner.new(sample_commands_config_file) }
    output.should include "Command 1"
    output.should include "Command 2"
    output.should include "Command 3"
  end

  context "run commands" do
    let(:runner) { CommandTimer::Runner.new(sample_commands_config_file) }

    it "should echo next command" do
      runner.stub(:count_down_and_burn_command)
      runner.stub(:wait_input_to_continue)
      output = capture_stdout { runner.start }
      output.should include "Next: Command1"
      output.should include "command on schedule"
      output.should include "Next: Command2"
      output.should include "command by user input"
      output.should include "Next: Command3"
      output.should include "command auto run"
    end

    context "burn time configured with detail time" do
      let(:command) { runner.instance_variable_get(:@commands)[0] }
      before(:each) do
        runner.stub(:wait_input_to_continue)
        runner.stub(:sleep)
      end

      it "should skip commands over the time" do
        fake_time = time_of_today(15, 0, 0)
        CommandTimer.stub(:ntp_time).and_return(fake_time)
        command.should_not_receive(:exec)
        output = capture_stdout { runner.start }
        output.should include "Time over."
      end

      it "should start count down and then execute it before burn time" do
        fake_time = time_of_today(13, 59, 30)
        CommandTimer.stub(:ntp_time).and_return(fake_time)
        command.should_receive(:exec)
        output = capture_stdout { runner.start }
        30.times do |i|
          output.should include "#{30 - i} seconds left"
        end
      end
    end

    context "burn time is blank" do
      let(:command) { runner.instance_variable_get(:@commands)[1] }
      before(:each) { runner.stub(:count_down_and_burn_command) }

      it "should wait user input when burn time is blank" do
        STDIN.stub(:gets).and_return("continue")
        output = capture_stdout { runner.start }
        output.should include "Input C to execute the next command or S to skip: "
      end

      it "should execute command when user input 'continue'" do
        STDIN.stub(:gets).and_return("continue")
        command.should_receive(:exec)
        output = capture_stdout { runner.start }
      end

      it "should skip next command when user input 'skip'" do
        STDIN.stub(:gets).and_return("skip")
        command.should_not_receive(:exec)
        output = capture_stdout { runner.start }
        output.should include "Command skipped."
      end
    end

    context "burn time configured with 'auto'" do
      let(:command) { runner.instance_variable_get(:@commands)[2] }
      before(:each) do
        runner.stub(:count_down_and_burn_command)
        runner.stub(:wait_input_to_continue)
      end

      it "should execute command immediately after previous done" do
        command.should_receive(:exec)
        output = capture_stdout { runner.start }
      end
    end
  end
end
