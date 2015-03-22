module MinAT
  class Lexer
    TEST_NUMBER = /^\d+\)/
    TAG_REGEX = /\s*\[(.*)\]/
    def parse_file(uri)
      @uri = uri
      prep_for_parse
      File.foreach(uri) do |line|
        @line = line
        if start_of_new_test?
          complete_test_parse
          create_new_test
        else
          @current_description += "\n#{@line.strip}"
        end
        @line_number += 1
      end
      complete_test_parse
      @tests
    end

    private
    def prep_for_parse
      @line_number, @current_test, @tests, @current_description = 1, nil, nil, ''
    end

    def start_of_new_test?
      (@line =~ TEST_NUMBER) == 0
    end

    def complete_test_parse
      if @tests
        @current_test.end_line = @line_number - 1
        @current_test.description = @current_description
        @tests << @current_test
      else
        #first time though. Just getting past the file description
        @tests = []
      end
    end

    def create_new_test
      @current_test = MinAT::Models::Test.new
      @current_test.start_line = @line_number
      @current_test.number = @line.match(TEST_NUMBER)[0][0..-2].to_i
      @current_test.tags = extract_tags @line
      @current_test.uri = @uri
      @current_description = @line.sub(TEST_NUMBER, '').sub(TAG_REGEX, '').strip
    end

    def extract_tags(line)
      if line =~ TAG_REGEX
        raw_tags = line.match(TAG_REGEX)[1]
        return raw_tags.split(/\s*,\s*/)
      end
      nil
    end
  end
end
