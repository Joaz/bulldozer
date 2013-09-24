class AcmeNut < CrystalScad::Assembly
  def initialize(args={})
    @args = args
    @args[:shape] = "cylinder"
    super
  end
  
  def show
    return cylinder_nut(false) if @args[:shape] == "cylinder"
    return hex_nut(false) if @args[:shape] == "hexagonal"
  end

  def output
    return cylinder_nut(true) if @args[:shape] == "cylinder"
    return hex_nut(true) if @args[:shape] == "hexagonal"
  end
  
  def cylinder_nut(output)
    if output == false
      nut = cylinder(d:22,h:20)
      nut -= cylinder(d:10,h:20.2).translate(z:-0.1)
    else
      nut = cylinder(d:22,h:20.7)
      nut += cylinder(d:13,h:40).translate(z:-10)
    end
    nut.color("Goldenrod")
  end
  
  def hex_nut
    # todo
  end
  
  
end

