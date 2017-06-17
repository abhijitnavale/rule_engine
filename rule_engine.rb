#!/usr/bin/env ruby

require_relative 'lib/engine'

eng = Engine.new

eng.read_rules()

eng.read_data_stream()

eng.apply_rules() 
