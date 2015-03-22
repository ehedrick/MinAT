require_relative 'spec_helper'

describe MinAT::Lexer do
  before { @lexer = MinAT::Lexer.new }
  describe '#extract_tags' do
    it 'returns nil if no tags supplied' do
      no_tags = '1) A test'
      expect(@lexer.send(:extract_tags, no_tags)).to be_nil
    end

    it 'returns an array of tags' do
      has_tags = "2) [tag1,tag2, tag3  ,  tag_chicken] another test"
      expect(@lexer.send(:extract_tags, has_tags)).to eq %w(tag1 tag2 tag3 tag_chicken)
    end
  end

  describe '#prep_for_parse' do
    before { @lexer.send(:prep_for_parse) }
    it 'sets up default information' do
      expect(@lexer.instance_variable_get(:@line_number)).to eq 1
      expect(@lexer.instance_variable_get(:@current_test)).to be_nil
      expect(@lexer.instance_variable_get(:@tests)).to be_nil
      expect(@lexer.instance_variable_get(:@current_description)).to eq ''
    end
  end

  describe '#start_of_new_test?' do
    it 'returns true if the line is the beginning of a test' do
      @lexer.instance_variable_set(:@line, '42) A new test')
      expect(@lexer.send(:start_of_new_test?)).to be true
    end

    it 'returns false if the line is not the beginning of a test' do
      @lexer.instance_variable_set(:@line, ' 2) not a new test')
      expect(@lexer.send(:start_of_new_test?)).to be false
    end
  end
end