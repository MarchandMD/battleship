class Cell
  attr_reader :coordinate, :ship, :fired_upon
  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired_upon = false
  end
  def empty?
    if @ship == nil
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
    @ship.hit 
    @fired_upon = true
  end
end
