require "command_timer/version"
require "command_timer/command"
require "command_timer/runner"
require "command_timer/parser"

module CommandTimer
  class << self
    def ntp_time(server = 'ntp.nict.jp')
      parse_time(%x[ntpdate -q #{server}].scan(/[0-9]{2}:[0-9]{2}:[0-9]{2}/).first)
    end

    def parse_time(str)
      hms = str.split(':').map(&:to_i)
      now = Time.now
      Time.new(now.year, now.month, now.day, hms[0], hms[1], hms[2])
    end
  end
end
