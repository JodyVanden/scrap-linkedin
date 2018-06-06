require 'json'
require 'yaml'
require 'pry-byebug'
require "csv"

class Scraping

  def initialize
      info_array = []
      file = File.open("info_linked_in.rb", 'r')
      while !file.eof?
        info = file.readline
        info = info.slice(info.index('{"isBlindQuery"')..-1)
        info.strip!
        info = info.gsub(/(?<=}-->).+/, "")

        info.chomp!('-->')
        string_to_array(info)
      end
    end

  def string_to_array(string)
   array = JSON.parse(string)
   array_value(array)

  end

  def array_value(infos)
    infos['searchResults'].map do |info|
      company_name = info['name'] if !info['name'].nil?
      company_industry = info['industry'] if !info['industry'].nil?

      p company_name
      csv(company_name,company_industry)
    end
  puts ""
  end

  def csv(company_name,company_industry)
    CSV.open("compagny.csv", "a+") do |csv|
      csv << [company_name, company_industry]
    end
  end
end


Scraping.new
