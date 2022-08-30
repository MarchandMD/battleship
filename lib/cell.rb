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
    if @ship != nil
        @ship.hit
        @fired_upon = true
    else
        @fired_upon = true
    end
  end
  def render(show = false)
    
    if @ship != nil
        if @ship.sunk? == true
            "X"
        elsif show == true 
            "S"
        elsif @fired_upon == true
            "H"    
        end
    elsif @fired_upon == false && show == false
        "."
    elsif @fired_upon == true && show == false && @ship == nil
        "M"
    
    end
  end
end
