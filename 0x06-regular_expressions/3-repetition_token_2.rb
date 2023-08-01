#!/usr/bin/env ruby

input_string = ARGV[0]
matches = input_string.scan(/\bh\w+n\b/)
puts matches.join
