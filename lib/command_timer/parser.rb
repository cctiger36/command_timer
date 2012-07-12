require "yaml"

module CommandTimer
  class Parser
    def self.parse(yml_path)
      yml_path += ".yml" unless yml_path.end_with?('.yml')
      yml = YAML.load_file(yml_path)
      commands = []
      yml.each do |cell|
        data = cell[1]
        command = Command.new
        data.each do |k, v|
          if ['content', 'observer'].include?(k)
            command.send("#{k}=", parse_commands(v))
          else
            command.send("#{k}=", v)
          end
        end
        commands << command
      end
      commands
    end

    def self.parse_commands(text)
      commands = ''
      text.each_line do |line|
        commands += line.strip
        commands += ';' unless line.end_with?(';')
      end
      commands
    end
  end
end
