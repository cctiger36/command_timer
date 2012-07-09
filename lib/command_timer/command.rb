module CommandTimer
  class Command
    attr_accessor :description
    attr_accessor :content
    attr_writer :burn_time

    def burn_time
      Runner.parse_time(@burn_time)
    end

    def exec
      puts "run #{@content}"
      system @content
    end
  end
end
