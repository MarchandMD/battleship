require './lib/cell'
require './lib/ship'
require 'spec_helper'

RSpec.describe Cell do
  it 'exists' do
    cell = Cell.new('B4')
    expect(cell).to be_a Cell
  end
  
  describe '#init' do
    # the 'cell' variable can be used in the 'it' blocks because the 'it' blocks are inside the describe block
    cell = Cell.new("B4")
    
    it 'is initialized with @coordinate instance variable' do
      expect(cell.coordinate).to be_a String
      expect(cell.coordinate).to eq("B4")
    end
    
    it 'is initialized with @ship instance variable' do
      expect(cell.ship).to eq(nil)
    end
  end
end
