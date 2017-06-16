#!/usr/bin/env ruby

require_relative 'lib/engine'

eng = Engine.new

eng.read_data_stream()
eng.read_rules()
eng.apply_rules()
