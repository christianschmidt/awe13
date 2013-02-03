require 'nokogiri'
require 'open-uri'

class MensaTag
  attr_accessor :datum, :wochentag, :gerichte
  def initialize(datum, wochentag)
    @datum = datum
    @wochentag = wochentag
    @gerichte = {} 
  end
  def get_tag()
    tag = "#{@wochentag} #{@datum}"
    @gerichte.each do |key, value|
       tag << " - #{key.upcase}: #{value}"
     end
    return tag
  end
end

mensaseite = Nokogiri::HTML(open("http://www.studentenwerk.bremen.de/files/main_info/essen/plaene/uniessen.php"))

woche = []

gerichte_positionen = {}
gerichte_positionen["Essen 1"] = 4
gerichte_positionen["Essen 2"] = 6

tag = MensaTag.new("25.01.2012", "Fr.")
tag.gerichte["Essen 1"] = "Steak mit Kartoffeln"
tag.gerichte["Essen 2"] = "Erbsensuppe"

puts tag.get_tag

5.times do |i|
  datum = mensaseite.xpath("/html/body/table/tr[3]/td[#{i+2}]/font/b").text
  wochentag = mensaseite.xpath("/html/body/table/tr[2]/td[#{i+2}]/font/b").text
  tag = MensaTag.new(datum, wochentag)

  gerichte_positionen.each do |key, value|
    tag.gerichte[key] = mensaseite.xpath("/html/body/table/tr[#{value}]/td[#{i+2}]/font/b").text
  end

  woche << tag
  puts tag.get_tag
end

