require 'pry'
class Turn
  attr_reader :human, :ai, :coord_array

  def initialize(human, ai)
    @human = human
    @ai = ai
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
    @coord_array = %w[A1 A2 A3 A4 B1 B2 B3 B4 C1 C2 C3 C4 D1 D2 D3 D4]
    
  end

  def ai_ship_placement
    loop do
      x = @coord_array.shuffle
      p x
      # binding.pry
      if @ai.valid_placement?(@cruiser, x[3..5])
        @ai.place(@cruiser, x[3..5])
        # @ai.place(@submarine, x[5..6])
        x.shift(3)
        # binding.pry
        break
      end
    end
  end
end
