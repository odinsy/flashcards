# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'nokogiri'
require 'open-uri'
require 'date'
data = "http://lingvotutor.ru/230-samyx-populyarnyx-anglijskix-fraz-en-ru"
doc = Nokogiri::HTML(open(data))
original = []
translated = []
doc.css('#tablepress-608').map do |column|
  column.css('.column-1').each do |i|
    original << i.text.strip
  end
  column.css('.column-2').each do |j|
    translated << j.text.strip
  end
end
hash = Hash[original.zip translated]
# puts hash # Just for test
hash.each do |a, b|
  Card.create(original_text: a, translated_text: b, review_date: Date.today)
end
