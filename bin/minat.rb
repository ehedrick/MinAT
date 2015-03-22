#!/usr/bin/env ruby
$:.unshift(File.dirname(__FILE__) + '/../lib')

require 'minat/cli'

MinAT::Cli.new(ARGV.dup).run