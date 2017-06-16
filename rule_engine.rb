#!/usr/bin/ruby

require_relative 'engine'

eng = Engine.new

eng.hello()
eng.connect_redis()
eng.read_data_stream()
