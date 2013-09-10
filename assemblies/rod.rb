class Rod
  def initialize(args={})
    @args = args
    @args[:length] ||= 500
    @args[:size] ||= 12    
    @args[:material] ||= "hardened steel, chrome plated"
    
    @@bom.add(description) unless args[:no_bom] == true    
  end
  
  def description
    "Precision rod #{@args[:size]}mm diameter, #{@args[:length]} long, #{@args[:material]}"
  end

  def show
    cylinder(d:@args[:size],h:@args[:length]).color("GhostWhite").rotate(x:-90)
  end
  
end
