class BulldozerMotor < CrystalScad::Assembly

  def part(show)
    m = Nema17.new    
    
    g1 = Gear.new(module:0.5,teeth:14,bore:5,height:8)
    g2 = Gear.new(module:0.5,teeth:80,bore:5,height:4)
        
    res = m.show.translate(z:-m.args[:length])
    
    res += g1.show.translate(z:5)
    res += g2.show.translate(x:g1.distance_to(g2),z:8)
    
  end
  
end
