#!/usr/bin/env ruby

input_string = ARGV[0]
match = input_string.match(/^\d{10}$/)
puts match[0] if match
