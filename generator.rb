# -*- coding: utf-8 -*-
require 'erb'
require './fetcher.rb'


module RSSIndex
  class Generator

    def initialize

    end

    def run
      fetcher = RSSIndex::Fetcher.new
      self.render(fetcher.result)
      self.write_to_file
    end

    def render(data)
      b = binding
      b.local_variable_set(:data, data)
      tpl_file = File.open('./index.html')
      html = ERB.new tpl_file.read
      @html = html.result(b)
      tpl_file.close
    end

    def write_to_file
      index = File.open('./public/index.html', 'w')
      index.write(@html)
      index.close
    end

  end
end

