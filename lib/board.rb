class Board
  attr_reader :cells, :player_occupied_cells, :computer_occupied_cells

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
    @player_occupied_cells = []
    @computer_occupied_cells = []
  end

  # used to determine if ship placement is valid; could this be used for guesses?
  def valid_coordinate?(coordinate)
    @cells.keys.include?(coordinate)
  end

  def valid_placement?(ship, array)
    array.each do |x|
      return false if @player_occupied_cells.include?(x)
    end

    if (valid_cruiser_placement(array) && ship.length == array.length) || (valid_submarine_placement(array) && ship.length == array.length)
      true
    else
      false
    end
  end


  def place_computer_ship(ship, array)
    cell_1 = @cells[array[0]]
    cell_2 = @cells[array[1]]
    cell_1.place_ship(ship)
    cell_2.place_ship(ship)
    if array.length == 3
      cell_3 = @cells[array[2]]
      cell_3.place_ship(ship)
    end
    array.each do |x|
      @computer_occupied_cells << x
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
    array.each do |x|
      @player_occupied_cells << x
    end
  end

  def render2(reveal = false)
    if reveal
      puts "  1 2 3 4 \nA #{@cells['A1'].render(true)} #{@cells['A2'].render(true)} #{@cells['A3'].render(true)} #{@cells['A4'].render(true)} \n" +
           "B #{@cells['B1'].render(true)} #{@cells['B2'].render(true)} #{@cells['B3'].render(true)} #{@cells['B4'].render(true)} \n" +
           "C #{@cells['C1'].render(true)} #{@cells['C2'].render(true)} #{@cells['C3'].render(true)} #{@cells['C4'].render(true)} \n" +
           "D #{@cells['D1'].render(true)} #{@cells['D2'].render(true)} #{@cells['D3'].render(true)} #{@cells['D4'].render(true)} \n"
    else
      puts "  1 2 3 4 \nA #{@cells['A1'].render} #{@cells['A2'].render} #{@cells['A3'].render} #{@cells['A4'].render} \nB #{@cells['B1'].render} #{@cells['B2'].render} #{@cells['B3'].render} #{@cells['B4'].render} \nC #{@cells['C1'].render} #{@cells['C2'].render} #{@cells['C3'].render} #{@cells['C4'].render} \nD #{@cells['D1'].render} #{@cells['D2'].render} #{@cells['D3'].render} #{@cells['D4'].render} \n"
    end
  end

  def valid_cruiser_placement(arr = 'computer')
    valid_cruiser_positions = [%w[A1 A2 A3],
                               %w[A2 A3 A4],
                               %w[B1 B2 B3],
                               %w[B2 B3 B4],
                               %w[C1 C2 C3],
                               %w[C2 C3 C4],
                               %w[D1 D2 D3],
                               %w[D2 D3 D4],
                               %w[A1 B1 C1],
                               %w[A2 B2 C2],
                               %w[A3 B3 C3],
                               %w[A4 B4 C4],
                               %w[B1 C1 D1],
                               %w[B2 C2 D2],
                               %w[B3 C3 D3],
                               %w[B4 C4 D4]]
    if arr == 'computer'
      valid_cruiser_positions.sample
    else
      valid_cruiser_positions.include?(arr)
    end
  end

  def valid_submarine_placement(arr = 'computer')
    valid_sub_positions = [%w[A1 A2],
                           %w[A2 A3],
                           %w[A3 A4],
                           %w[B1 B2],
                           %w[B2 B3],
                           %w[B3 B4],
                           %w[C1 C2],
                           %w[C2 C3],
                           %w[C3 C4],
                           %w[D1 D2],
                           %w[D2 D3],
                           %w[D3 D4],
                           %w[A1 B1],
                           %w[A2 B2],
                           %w[A3 B3],
                           %w[A4 B4],
                           %w[B1 C1],
                           %w[B2 C2],
                           %w[B3 C3],
                           %w[B4 C4],
                           %w[C1 D1],
                           %w[C2 D2],
                           %w[C3 D3],
                           %w[C4 D4]]

    if arr == 'computer'
      valid_sub_positions.shuffle.pop
    else
      valid_sub_positions.include?(arr)
    end
  end
end
