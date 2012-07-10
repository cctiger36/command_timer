module CommandTimer
  class Command
    attr_accessor :description
    attr_accessor :content
    attr_writer :burn_time

    def burn_time
      CommandTimer.parse_time(@burn_time)
    end

    def exec
      echo_command
      system @content
    end

    def echo_command
      @content.split(';').each do |line|
        puts ">> #{line.strip.gsub('\\', '')}"
      end
    end
  end
end
