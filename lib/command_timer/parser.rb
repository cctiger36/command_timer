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
          if k == 'content'
            command.content = ''
            v.each_line do |line|
              command.content += line.strip
              command.content += ';' unless command.content.end_with?(';')
            end
          else
            command.send("#{k}=", v)
          end
        end
        commands << command
      end
      commands
    end
  end
end
