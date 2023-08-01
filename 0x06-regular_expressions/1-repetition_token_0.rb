#!/usr/bin/env ruby

input_string = ARGV[0]
matches = input_string.scan(/\bh\w*t{2,5}n\b/)
puts matches.join
