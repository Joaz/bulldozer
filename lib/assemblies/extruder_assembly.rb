class ExtruderAssembly < CrystalScad::Assembly

  def part(show)
    res = XCarriage.new.show.rotate(y:-90,z:180).translate(x:22)
    
    res += MGS_Old.new.show.translate(y:35)
    
    res += LevelingEndstop.new.show.translate(x:64,y:14,z:-90)
  
  end
  
end
