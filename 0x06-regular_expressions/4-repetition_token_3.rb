#!/usr/bin/env ruby

input_string = ARGV[0]
matches = input_string.scan(/\bh\w*t\wn\b/)
puts matches.join
