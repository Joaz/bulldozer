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
    nut = cylinder(d:22,h:20)
    if output == false
      nut -= cylinder(d:10,h:20.2).translate(z:-0.1)
    else
      nut += cylinder(d:12,h:30).translate(z:-5)
    end
    nut.color("Goldenrod")
  end
  
  def hex_nut
    # todo
  end
  
  
end

