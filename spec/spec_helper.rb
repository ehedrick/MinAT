require 'rspec'
require 'rspec/expectations'
require 'rspec/mocks'
require 'minat'
require 'simplecov'

SimpleCov.start do
  add_filter '/spec/'
  add_filter '/bin/'
end