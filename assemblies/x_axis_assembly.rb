class XAxisAssembly < CrystalScad::Assembly
  def initialize(args={})
    @args=args
    @args[:position] ||= 15
  end
  
  def show
    # z bearings
    axis  = Lm_uu.new(inner_diameter:12).rotate(x:0).translate(y:40,x:15,z:-50)
    axis += Lm_uu.new(inner_diameter:12).rotate(x:0).translate(y:40,x:15,z:35)
    
    axis += Lm_uu.new(inner_diameter:12).rotate(x:0).translate(y:40,x:15+270,z:-30)
    axis += Lm_uu.new(inner_diameter:12).rotate(x:0).translate(y:40,x:15+270,z:35)

    axis += TSlot.new(size:30).show(300).rotate(y:90).color("Silver")
    axis += Rod.new(length:307).show.rotate(z:-90).translate(y:15,z:15,x:-3.5)
    axis += Rod.new(length:307).show.rotate(z:-90).translate(y:-15,z:-15,x:-3.5)
    axis += Lm_uu.new(inner_diameter:12).rotate(y:90).translate(y:15,z:15,x:@args[:position]+20)
    axis += Lm_uu.new(inner_diameter:12).rotate(y:90).translate(y:-15,z:-15,x:@args[:position])
    axis += Lm_uu.new(inner_diameter:12).rotate(y:90).translate(y:-15,z:-15,x:@args[:position]+40)
    #axis += Belt.new(longest_side_length:280,top_side_length:250).show.rotate(z:-90,y:90).translate(x:13,y:-10,z:10)
    #axis += Nema17.new.show.rotate(x:180).translate(x:13,y:-5,z:75)
    axis += AcmeNut.new.show.translate(x:-23,y:15,z:-5)
    
    axis +=  Nema17.new.show.rotate(x:90).translate(x:30,y:95,z:25)
    axis += Belt.new(longest_side_length:270,top_side_length:250,position:20).show.rotate(z:-90,y:180).translate(x:30,y:30,z:25-7)
   
		axis += XAxisMountingPart.new.show.translate(x:-5,y:-30,z:30)

   end
end

