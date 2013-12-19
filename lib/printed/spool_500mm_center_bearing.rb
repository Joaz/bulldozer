class Spool500mmCenterBearing < CrystalScad::Assembly

  def show
    part
  end
  
  def output
    part
  end

  def part
    height = 62
    core_dia = 14
    res = cylinder(d:55.9,h:height)
    res+= cylinder(d:80,h:2)

    res -= cylinder(d:core_dia,h:height)
    
    b = Bearing.new(size:608, margin_diameter:0.2)
    res-= b.output
    
    b_dia= b.size[:outer_diameter] + 0.2
    b_height = b.size[:thickness]
    
    b = Bearing.new(size:608)
    res-= b.output.translate(z:height-b_height)

    res -= cylinder(d1:b_dia,d2:core_dia,h:(height-b_height)/2).translate(z:b_height)
    
    
  end

end
