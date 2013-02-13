require 'test/unit'

require_relative 'romanizer'

class TestRomanizer < Test::Unit::TestCase
  include Test::Unit::Assertions
  
  # vor jedem Test ausfuehren
  def setup
    # 5000 = "\u2181" http://unicode.org/cldr/utility/character.jsp?a=2181
    # 10000 = http://unicode.org/cldr/utility/character.jsp?a=2182
    @faelle_simple = {
      "I" => 1,
      "II" => 2,
      "III" => 3,
      "IIII" => 4,
      "V" => 5,
      "VI" => 6,
      "VII" => 7,
      "VIII" => 8,
      "VIIII" => 9,
      "X" => 10,
      "XI" => 11,
      "XIIII" => 14,
      "XV" => 15,
      "XVIIII" => 19,
      "XXXX" => 40,
      "XXXXVIIII" => 49,
      "L" => 50,
      "LI" => 51,
      "C" => 100,
      "CI" => 101,
      "CV" => 105,
      "CL" => 150,
      "D" => 500,
      "M" => 1000,
      "\u2181" => 5000,
      "\u2182" => 10000
    }
    @faelle_complex = {
      "I" => 1,
      "II" => 2,
      "III" => 3,
      "IV" => 4,
      "V" => 5,
      "VI" => 6,
      "VII" => 7,
      "VIII" => 8,
      "IX" => 9,
      "X" => 10,
      "XI" => 11,
      "XIV" => 14,
      "XV" => 15,
      "XIX" => 19,
      "XL" => 40,
      "XLIX" => 49,
      "L" => 50,
      "LI" => 51,
      "C" => 100,
      "CI" => 101,
      "CV" => 105,
      "CL" => 150,
      "D" => 500,
      "M" => 1000,
      "\u2181" => 5000,
      "\u2182" => 10000
    }
    @faelle_simple_fehler = ["a", "K", "x", "IX"]    
  end
  # nach jedem Test ausfuehren
  def teardown
  end	
  # testet die faelle fuer simple umrechnung roemisch->arabisch
  def test_to_arabic_simple
    @faelle_simple.each do |key, value|
      assert_equal(value, Romanizer.to_arabic_simple(key));
    end
  end
  # testet die faelle fuer simple umrechnung arabisch->roemisch 
  def test_to_roman_simple
    @faelle_simple.each do |key, value|
      assert_equal(key, Romanizer.to_roman_simple(value));
    end
  end
  # testet die fehlerfaelle fuer simple umrechnung arabisch->roemisch 
  def test_to_arabic_simple_err
    @faelle_simple_fehler.each do |key|
      assert_equal(nil, Romanizer.to_arabic_simple(key));
    end
  end
  # testet die faelle fuer umrechnung nach substraktionsregel roemisch->arabisch
  def test_to_arabic_complex
    @faelle_complex.each do |key, value|
      assert_equal(value, Romanizer.to_arabic_complex(key));
    end
  end
  # testet die faelle fuer umrechnung nach substraktionsregel arabisch->roemisch 
  def test_to_roman_complex
    @faelle_complex.each do |key, value|
      assert_equal(key, Romanizer.to_roman_complex(value));
    end
  end
end
