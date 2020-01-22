# -*- coding: utf-8 -*-
require 'date'
require './generator.rb'

loop do
  now = DateTime.now.to_s
  puts "#{now}: Index Generator is running..."
  generator = RSSIndex::Generator.new
  generator.run
  puts "#{now}: generate index.html has done."
  sleep(3600 * 24)
end
