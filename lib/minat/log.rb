require 'logger'

module MinAT
  class Log
    class << self
      def instance
        return @logger if @logger
        @logger = Logger.new(STDOUT)
        @logger.progname = 'MinAT'
        @logger.level = Logger::INFO
        @logger
      end

      def logger=(new_logger)
        @logger = new_logger
      end
    end
  end
end

