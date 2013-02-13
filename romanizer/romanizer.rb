class Romanizer
  # Zeichen -> Zeichen zuordnung 
  ZEICHEN_WERTE = {
    "I" => 1,
    "V" => 5,
    "X" => 10,
    "L" => 50,
    "C" => 100,
    "D" => 500,
    "M" => 1000
  }
  # Werte -> Zeichen zuordnung (explizit nochmal, wegen ggf. moeglichen sondernfaellen)
  WERTE_ZEICHEN = {
    1 => "1",
    5 => "V",
    10 => "X",
    50 => "L",
    100 => "C",
    500 => "D", 
    1000 => "M"
  }

  # wandelt eine Zahl aus arabischer in roemische zahlschrift um, wendet einfache umrechnung an
  def self.to_roman_simple number
  	return nil
  end
  # wandelt eine Zahl aus roemischee in arabische zahlschrift um, wendet einfache umrechnung an (dabei muss uebergebene zeichenkette nach definition absteigend sortiert sein)
  def self.to_arabic_simple zeichenkette
    @res = 0
    
    # wenn erstes zeichen bekannt ist, auf vergleichsbuffer setzen, sonst return nil
    if ZEICHEN_WERTE.has_key?(zeichenkette.chars.first)
      @last_value = ZEICHEN_WERTE[zeichenkette.chars.first]
    else
      return nil
    end

    zeichenkette.each_char do |c|
    	# falls unbekanntes zeichen enthalten ist sofort nil zurueckliefern
        return nil unless ZEICHEN_WERTE.has_key?(c)

        # falls neues zeichen groesser als letztes, nil zurueckgeben
		return nil if ZEICHEN_WERTE[c] > @last_value;

        # zeichenwert auf rueckgabebuffer addieren
    	@res += ZEICHEN_WERTE[c];
    end
    
    # additionsbuffer rueckliefern
  	return @res
  end
  # wandelt eine Zahl aus arabischer in roemische zahlschrift um, wendet umrechnung mit substraktionsregel an
  def self.to_roman_complex number
  	return nil
  end
  # wandelt eine Zahl aus roemischer in arabische zahlschrift um, wendet umrechnung mit substraktionsregel an
  def self.to_arabic_complex zeichenkette
  	return nil
  end
end
