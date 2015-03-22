require_relative 'spec_helper'

describe MinAT::Log do
  describe '#instance' do
    context 'when there is no logger' do
      it 'creates a new logger' do
        MinAT::Log.instance_variable_set(:@logger, nil)
        MinAT::Log.instance
        expect(MinAT::Log.instance_variable_get :@logger).to be_a Logger
      end
    end

    context 'when there is already a logger' do
      before { @original_logger = MinAT::Log.instance }
      it 'returns the logger instance' do
        expect(MinAT::Log.instance).to eq(@original_logger)
      end
    end

    it 'defaults to STDOUT' do
      expect(MinAT::Log.instance.instance_variable_get(:@logdev).dev).to eq STDOUT
    end

    it 'has a default log level of info' do
      expect(MinAT::Log.instance.level).to eq Logger::INFO
    end

    it 'sets the progname to MinAT' do
      expect(MinAT::Log.instance.progname).to eq 'MinAT'
    end
  end

  describe '#logger=' do
    it 'overrides the existing logger' do
      original = MinAT::Log.instance
      MinAT::Log.logger = Logger.new(STDOUT)
      expect(MinAT::Log.instance).to_not eq original
    end
  end
end