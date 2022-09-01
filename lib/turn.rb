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
      @coord_array.shuffle
      next unless @ai.valid_placement?(@cruiser, @coord_array[0..2]) && @ai.valid_placement?(@submarine, @coord_array[3..4])

      @ai.place(@cruiser, @coord_array[0..2])
      @ai.place(@submarine, @coord_array[3..4])
      break
    end
  end
end
