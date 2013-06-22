$:.unshift File.expand_path(File.dirname(__FILE__) + '/../lib')

require 'command_timer'

def capture_stdout(&block)
  original_stdout = $stdout
  $stdout = fake = StringIO.new
  begin
    yield
  ensure
    $stdout = original_stdout
  end
  fake.string
end

def sample_commands_config_file
  File.join(File.dirname(__FILE__), "commands")
end
