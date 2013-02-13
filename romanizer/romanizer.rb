class Romanizer
  # Werte -> Zeichen zuordnung. Absteigend wichtig!
  WERTE_ZEICHEN_SIMPLE = {
    10000 => "\u2182",
    5000 => "\u2181",
    1000 => "M",
    500 => "D",
    100 => "C",
    50 => "L",
    10 => "X",
    5 => "V",
    1 => "I"
  }
  
  # Zeichen -> Werte zuordnung
  ZEICHEN_WERTE_SIMPLE = WERTE_ZEICHEN_SIMPLE.invert

  # Werte -> Zeichen zuordnung fuer complex methode (erstmal explizit nochmal, wegen ggf. moeglichen sondernfaellen?). Absteigend wichtig!
  WERTE_ZEICHEN_COMPLEX = {
    10000 => "\u2182",
    5000 => "\u2181",
    4000 => "M\u2181",
    1000 => "M",
    999 => "CMXCIX",
    990 => "CMXC",
    900 => "CM",
    500 => "D",
    499 => "ID",
    490 => "XD",
    400 => "CD",
    100 => "C",
    90 => "XC",
    50 => "L",
    49 => "IL",
    40 => "XL",
    10 => "X",
    9 => "IX",
    5 => "V",
    4 => "IV",
    1 => "I"
  }
  
  # Zeichen -> Werte zuordnung
  ZEICHEN_WERTE_COMPLEX = WERTE_ZEICHEN_COMPLEX.invert

  # wandelt eine Zahl aus arabischer in roemische zahlschrift um, wendet einfache umrechnung an
  def self.to_roman_simple number
    @res = ""
    @rest = number
    WERTE_ZEICHEN_SIMPLE.each do |key, value|
      ganzzahl = @rest / key      
      ganzzahl.times { @res << value }
      @rest = @rest % key
    end
    return @res
  end
  # wandelt eine Zahl aus roemischee in arabische zahlschrift um, wendet einfache umrechnung an (dabei muss uebergebene zeichenkette nach definition absteigend sortiert sein)
  def self.to_arabic_simple zeichenkette
    @res = 0
    
    # wenn erstes zeichen bekannt ist, auf vergleichsbuffer setzen, sonst return nil
    if ZEICHEN_WERTE_SIMPLE.has_key?(zeichenkette.chars.first)
      @last_value = ZEICHEN_WERTE_SIMPLE[zeichenkette.chars.first]
    else
      return nil
    end

    zeichenkette.each_char do |c|
    	# falls unbekanntes zeichen enthalten ist sofort nil zurueckliefern
        return nil unless ZEICHEN_WERTE_SIMPLE.has_key?(c)

        # falls neues zeichen groesser als letztes, sofort nil zurueckgeben
		return nil if ZEICHEN_WERTE_SIMPLE[c] > @last_value

        # zeichenwert auf rueckgabebuffer addieren
    	@res += ZEICHEN_WERTE_SIMPLE[c]
    end
    
    # additionsbuffer rueckliefern
  	return @res
  end
  # wandelt eine Zahl aus arabischer in roemische zahlschrift um, wendet bei umrechnung substraktionsregel an
  def self.to_roman_complex number
  	@res = ""
    @rest = number
    WERTE_ZEICHEN_COMPLEX.each do |key, value|
      ganzzahl = @rest / key      
      ganzzahl.times { @res << value }
      @rest = @rest % key
    end
    return @res
  end
  # wandelt eine Zahl aus roemischer in arabische zahlschrift um, wendet umrechnung auf mit substraktionsregel vorliegende zeichenketten an
  def self.to_arabic_complex zeichenkette
    @res = 0
    @pos_beg = 0
    @pos_end = zeichenkette.length
    while @pos_end > 0
      partial = zeichenkette.slice(@pos_beg, @pos_end)
      if ZEICHEN_WERTE_COMPLEX.has_key?(partial) 
        @res += ZEICHEN_WERTE_COMPLEX[partial]
        @pos_beg += @pos_end
        @pos_end = zeichenkette.length - @pos_beg +1
      end
      return nil if (@pos_end -= 1) < 0
    end
    return @res
  end
end