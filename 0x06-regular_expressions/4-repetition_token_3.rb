#!/usr/bin/env ruby

input_string = ARGV[0]
matches = input_string.scan(/\bh.t.n\b/)
puts matches.join
