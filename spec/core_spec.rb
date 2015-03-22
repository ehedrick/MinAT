require_relative 'spec_helper'

describe MinAT::Core do
  before do
    @core = MinAT::Core.new('/tests')
  end

  describe '#locate_tests_files' do
    it 'sets @test_files based on the current location' do
      files = %w(first_file.tests second_file.tests)
      allow(Dir).to receive(:[]).and_return(files)
      @core.locate_tests_files
      expect(@core.instance_variable_get(:@test_files)).to eq files
    end

    it 'returns a list of test file paths' do
      files = %w(first_file.tests second_file.tests)
      allow(Dir).to receive(:[]).and_return(files)
      result = @core.locate_tests_files
      expect(result).to eq files
    end
  end

  describe '#locate_runner_files' do
    it 'sets @runner_files based on the current location' do
      files = %w(first_file.rb second_file.rb)
      allow(Dir).to receive(:[]).and_return(files)
      @core.locate_runner_files
      expect(@core.instance_variable_get(:@runner_files)).to eq files
    end

    it 'returns a list of runner file paths' do
      files = %w(first_file.rb second_file.rb)
      allow(Dir).to receive(:[]).and_return(files)
      result = @core.locate_runner_files
      expect(result).to eq files
    end
  end

  describe '#verify_all_runner_files_present' do
    context 'when runners are missing' do
      it 'throws a MissingRunnersError' do
        @core.instance_variable_set(:@test_files, ['a_file.tests'])
        allow(Dir).to receive(:[]).and_return([])
        expect { @core.verify_all_runner_files_present }.to raise_error(MinAT::Core::MissingRunnersError)
      end
    end

    context 'when runners are not missing' do
      it 'does not throw any errors' do
        @core.instance_variable_set(:@test_files, ['a_file.tests'])
        allow(Dir).to receive(:[]).and_return(['a_file.rb'])
        expect { @core.verify_all_runner_files_present }.to_not raise_error
      end
    end
  end

end
