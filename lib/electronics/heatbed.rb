class Heatbed
  attr_accessor :size
  
  def initialize(args={})
    @size = {:x => 214, 
             :y => 214,
             :z => 1.58}
    
    @@bom.add(description) unless args[:no_bom] == true
  end
  
  def description
    "Heatbed pcb, Aluminium"
  end
  
  def show
    bed = cube([@size[:x],@size[:y],@size[:z]])
    # leaving it simple here, no holes
    bed.color("Silver")
  end
end
