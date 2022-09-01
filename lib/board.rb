class Board
  attr_reader :cells

  def initialize
    @cells = {
      'A1' => Cell.new('A1'),
      'A2' => Cell.new('A2'),
      'A3' => Cell.new('A3'),
      'A4' => Cell.new('A4'),
      'B1' => Cell.new('B1'),
      'B2' => Cell.new('B2'),
      'B3' => Cell.new('B3'),
      'B4' => Cell.new('B4'),
      'C1' => Cell.new('C1'),
      'C2' => Cell.new('C2'),
      'C3' => Cell.new('C3'),
      'C4' => Cell.new('C4'),
      'D1' => Cell.new('D1'),
      'D2' => Cell.new('D2'),
      'D3' => Cell.new('D3'),
      'D4' => Cell.new('D4')
    }
  end

  def valid_coordinate?(coordinate)
    if @cells.keys.include?(coordinate)
      true
    else
      false
    end
  end

  def valid_placement?(ship, array)
    letters = []
    numbers = []

    array.each do |coordinate|
      letters << coordinate[0]
      numbers << coordinate[1]
    end

    letters = letters.join
    numbers = numbers.join

    board_rows = 'ABCD'
    board_columns = '1234'

    # the first if statement
    if board_rows.include?(letters) || board_columns.include?(numbers) && array.length == ship.length
      # the second if statement
      if letters.length == numbers.length && board_rows.include?(letters) && board_columns.include?(numbers)
        false
      else
        true
      end
    else
      false
    end
  end
  def place(ship, array)
    cell_1 = @cells[array[0]]
    cell_2 = @cells[array[1]]
    cell_1.place_ship(ship)
    cell_2.place_ship(ship)
    if array.length == 3
      cell_3 = @cells[array[2]]
      cell_3.place_ship(ship)
    end
  end
end
