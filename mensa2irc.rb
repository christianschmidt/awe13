class MensaTag
  attr_accessor :datum, :wochentag, :gerichte
  def initialize(datum, wochentag)
    @datum = datum
    @wochentag = wochentag
    @gerichte = {} 
   end
   def print_tag()
      print "#{@wochentag} #{@datum}"
      gerichte.each do |key, value|
        print " - #{key.upcase}: #{value}"
      end
      print "\n"
   end
end

tag = MensaTag.new("27.01.2012", "Mo.")
tag.gerichte["essen1"] = "Steak mit Kartoffeln"
tag.gerichte["essen2"] = "Erbsensuppe"

tag.print_tag
