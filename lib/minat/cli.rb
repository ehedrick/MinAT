require 'minat'
require 'minat/core'

module MinAT
  class Cli
    def initialize(*args)
      MinAT.logger.level = Logger::DEBUG
    end

    def run
      core = MinAT::Core.new(Dir.pwd)
      core.locate_tests_files
      # core.verify_all_runner_files_present
      #TODO: all of this
      core.parse_tests
      #core.load_setup
      #core.load_support
      #core.load_runners
    end
  end
end
