class Cell
  attr_reader :coordinate, :ship, :fired_upon

  def initialize(coordinate = 'a1', ship = nil, fired_upon = false)
    @coordinate = coordinate
    @ship = ship
    @fired_upon = fired_upon
  end

  def empty?
    if @ship.nil?
      true
    else
      false
    end
  end

  def place_ship(boat_name)
    @ship = boat_name
  end

  def fired_upon?
    @fired_upon
  end

  def fire_upon
    if !@ship.nil?
      @ship.hit
      @fired_upon = true
    else
      @fired_upon = true
    end
  end

  def render(show = false)
    if ship_present?
      if @ship.sunk?
        'X'
      elsif ship_was_hit(show)
        'H'
      elsif show
        'S'
      else
        '.'
      end
    elsif @fired_upon == false
        '.'
    elsif @fired_upon == true && @ship.nil?
      'M'
    end
  end

  def ship_was_hit(show)
    show && @fired_upon || @fired_upon
  end

  def ship_present?
    !@ship.nil?
  end

end
