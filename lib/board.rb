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
      if @cells[coordinate].ship.nil?
        letters << coordinate[0]
        numbers << coordinate[1]
      else
        return false
      end
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

  def render2(reveal = false)
    if reveal
      puts "  1 2 3 4 \nA #{@cells['A1'].render(true)} #{@cells['A2'].render(true)} #{@cells['A3'].render(true)} #{@cells['A4'].render(true)} \nB #{@cells['B1'].render(true)} #{@cells['B2'].render(true)} #{@cells['B3'].render(true)} #{@cells['B4'].render(true)} \nC #{@cells['C1'].render(true)} #{@cells['C2'].render(true)} #{@cells['C3'].render(true)} #{@cells['C4'].render(true)} \nD #{@cells['D1'].render(true)} #{@cells['D2'].render(true)} #{@cells['D3'].render(true)} #{@cells['D4'].render(true)} \n"
    else
      puts "  1 2 3 4 \nA #{@cells['A1'].render} #{@cells['A2'].render} #{@cells['A3'].render} #{@cells['A4'].render} \nB #{@cells['B1'].render} #{@cells['B2'].render} #{@cells['B3'].render} #{@cells['B4'].render} \nC #{@cells['C1'].render} #{@cells['C2'].render} #{@cells['C3'].render} #{@cells['C4'].render} \nD #{@cells['D1'].render} #{@cells['D2'].render} #{@cells['D3'].render} #{@cells['D4'].render} \n"
    end
  end
end
