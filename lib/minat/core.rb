module MinAT
  class Core
    class MissingRunnersError < Exception
    end

    def initialize(running_from)
      @starting_path = running_from
    end

    def locate_tests_files
      @test_files = Dir["#{@starting_path}/tests/**/*.tests"].uniq.sort
    end

    def locate_runner_files
      @runner_files = Dir["#{@starting_path}/runners/**/*.rb"].uniq.sort
    end

    def verify_all_runner_files_present
      expected_file_names = @test_files.dup
      expected_file_names.map! { |file_name| file_name.sub("#{@starting_path}/tests/", "#{@starting_path}/runners/").sub('.tests', '.rb') }
      actual_runners = locate_runner_files
      missing_files = []
      expected_file_names.each { |expected| missing_files << expected unless actual_runners.include? expected}
      raise MissingRunnersError.new("These runners are missing: #{missing_files}") unless missing_files.empty?
    end

    def parse_tests
      lexer = Lexer.new
      @test_files.each { |file| lexer.parse_file(file) }
    end
  end
end

