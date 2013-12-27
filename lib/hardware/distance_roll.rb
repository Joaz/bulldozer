class DistanceRoll < CrystalScad::Assembly
  
  def initialize(args={})
    super
    @args[:height] ||= 20
    @args[:diameter] ||= 6
    @args[:inner_diameter] ||= 3.4
  end
  
  def show
    res = cylinder(d:@args[:diameter],h:@args[:height])
    res -= cylinder(d:@args[:inner_diameter],h:@args[:height]+0.2).translate(z:-0.1)
    res.color("Gray")
  end

end
