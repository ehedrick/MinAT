module MinAT
  module Models
    class Test
      attr_accessor :number, :description, :start_line, :end_line, :tags, :uri

      def to_s
        puts "Test \##{number}"
        puts "Tags: #{tags}"
        puts "From line #{start_line} to line #{end_line}"
        puts "Description:"
        puts description
        puts "\n"
      end
    end
  end
end
