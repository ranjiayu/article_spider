# -*- coding: utf-8 -*-
require 'net/http'
require 'rexml/document'

module RSSIndex

  class Fetcher
    @@resources = {
      hacker_news: 'https://hnrss.org/frontpage',
      ruby_weekly: 'https://rubyweekly.com/rss',
      infoq: 'https://www.infoq.cn/feed.xml'
    }

    def initialize
      @result = {}
      @@resources.each_key do |resource|
        self.get_items_by_name(resource)
      end
    end

    def get_items_by_name(name)
      result = []
      uri = URI @@resources[name]
      res = Net::HTTP.get_response(uri)
      doc = REXML::Document.new res.body
      articles = doc.elements[1].elements[1].elements
      articles.each('item') do |article|
        result << {
          title: article.get_elements('title')[0].get_text,
          link: article.get_elements('link')[0].get_text
        }
      end
      @result[name] = result
    end

    def result
      @result
    end
  end

end