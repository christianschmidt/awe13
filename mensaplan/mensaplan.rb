require 'nokogiri'
require 'open-uri'
require 'socket'

class MensaTag
  attr_accessor :datum, :wochentag, :gerichte
  def initialize(datum, wochentag)
    @datum = datum
    @wochentag = wochentag
    @gerichte = {} 
  end
  # erstellt einen String aus den daten des tages und liefert diesen zurueck
  def get_tag()
    tag = "#{@wochentag} #{@datum}"
    @gerichte.each do |key, value|
       tag << " - #{key.upcase}: #{value}"
     end
    return tag
  end
end

# daten senden ja/nein, daten des zielhost (hostname oder ip, port)
ZIEL_SEND = false
ZIEL_HOST = 'zielhost.name'
ZIEL_PORT = 6666

# mensaseite per nokogiri holen
mensaseite = Nokogiri::HTML(open("http://www.studentenwerk.bremen.de/files/main_info/essen/plaene/uniessen.php"))
# nicht benoetigte zeilenumbrueche duch leerzeichen ersetzen
mensaseite.search('br').each { |br| br.replace(" ") }

# array fuer wochentage
woche = []

# positionen der gerichte in der mensaseite angeben (fuer xpath) 
GERICHTE_POSITIONEN = {
  "Essen 1" => 4,
  "Essen 2" => 6,
  "Vegetarisch" => 20,
  "Wok, Pfanne & Co." => 28,
}

# wochentage durchlaufen
(2..6).each do |i|
  # datum und wochentag aus mensaseite holen
  datum = mensaseite.xpath("/html/body/table/tr[3]/td[#{i}]/font/b").text
  wochentag = mensaseite.xpath("/html/body/table/tr[2]/td[#{i}]/font/b").text
  
  # mensaTag Objekt mit datum und wochentag initialisieren
  tag = MensaTag.new(datum, wochentag)

  # alle gewuenschten mahlzeiten durchlaufen und anhand der hinterlegten position aus der mensaseite holen
  GERICHTE_POSITIONEN.each do |key, value|
    tag.gerichte[key] = mensaseite.xpath("/html/body/table/tr[#{value}]/td[#{i}]/font/b").text.strip.squeeze(" ")
  end

  # tag in array der woche einfuegen
  woche << tag
end

# array der woche durchlaufen
woche.each do |tag|
  # falls daten gesendet werden sollen, dann machen...
  if ZIEL_SEND
    # neuen socket erstellen und zeile des tages senden (workaround hier: immer neuer socket, da derzeitiger zielhost nur einmalig eine zeile annimmt...)
    s = TCPSocket.new ZIEL_HOST, ZIEL_PORT
    s.puts tag.get_tag
  end

  # zeile lokal ausgeben
  puts tag.get_tag
end


