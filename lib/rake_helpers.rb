$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'rake_helpers/config'
require 'rake_helpers/erb_helper'

module RakeHelpers
  VERSION = '0.0.4'
end