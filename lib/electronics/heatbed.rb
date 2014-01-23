class Heatbed < CrystalScad::Assembly
  attr_accessor :size,:hole_positions
  
  def initialize(args={})
    @x = 214
    @y = 214
    @z = 1.58
    
    @size = {:x => @x, 
             :y => @y,
             :z => @z}
    
    @hole_positions = [{x:2.5,y:2.5},{x:209+2.5,y:2.5},{x:2.5,y:209+2.5},{x:209+2.5,y:209+2.5}]
    @@bom.add(description) unless args[:no_bom] == true
  end
  
  def description
    "Heatbed pcb, Aluminium"
  end
  
  def show
    bed = cube([@x,@y,@z])
    # leaving it simple here, no holes
    bed.color("Silver")
  end
end
