require_relative "minat/version"
require_relative 'minat/log'
require_relative 'minat/cli'
require_relative 'minat/core'
require_relative 'minat/lexer'
require_relative 'minat/log'
require_relative 'models'

module MinAT
  def self.logger
    MinAT::Log.instance
  end
end
