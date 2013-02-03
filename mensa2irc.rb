class MensaTag
  attr_accessor :datum, :wochentag, :gerichte
end

tag = MensaTag.new
tag.datum = "27.01.2012"
tag.wochentag = "Mo."
tag.gerichte = {}
tag.gerichte["essen1"] = "Steak mit Kartoffeln"
tag.gerichte["essen2"] = "Erbsensuppe"

tag
