class XAxisAssembly < CrystalScad::Assembly
  def initialize(args={})
    @args=args
    @args[:position] ||= 15+00
  end
  
  def show
    # z bearings
    axis  = ZBearingHolder.new(inner_diameter:12).show.rotate(x:0).translate(y:44,x:17.5,z:-46)
   # axis += Lm_uu.new(inner_diameter:12).rotate(x:0).translate(y:43,x:17.5,z:35)
    
    #axis += Lm_uu.new(inner_diameter:12).rotate(x:0).translate(y:43,x:17.5+265,z:-50)
   # axis += Lm_uu.new(inner_diameter:12).rotate(x:0).translate(y:43,x:17.5+265,z:35)

    axis += TSlot.new(size:30).show(300).rotate(y:90).color("Silver")
    axis += Rod.new(length:307).show.rotate(z:-90).translate(y:15,z:15,x:-3.5)
    axis += Rod.new(length:307).show.rotate(z:-90).translate(y:-15,z:-15,x:-3.5)

    axis += XCarriage.new().show.rotate(y:90).translate(x:1+@args[:position],y:-30,z:30) #.rotate(z:-90).translate(y:-15,z:-15,x:-3.5)

		axis += MGS.new.show.rotate(z:0).rotate(x:90).translate(x:@args[:position]+27,y:-60,z:23)
#		axis += JHead.new.show.translate(x:@args[:position]+39.5-5,y:-51.5,z:-73)
#		axis += cylinder(d:3,h:150).color("Red").translate(x:@args[:position]+40-0.5-5,y:-51.5,z:-69)	

    #axis += Belt.new(longest_side_length:280,top_side_length:250).show.rotate(z:-90,y:90).translate(x:13,y:-10,z:10)
    #axis += Nema17.new.show.rotate(x:180).translate(x:13,y:-5,z:75)
    #axis += AcmeNut.new(no_bom:true).show.translate(x:-23,y:15,z:5) # bom entry in x_axis_acme_nut_holder
    
    #motor =  Nema17.new.show.rotate(x:90).translate(x:32,y:102,z:25)
    #motor +=  Pulley.new.show.rotate(x:90).translate(x:32,y:42.5,z:25)
    #motor += Belt.new(longest_side_length:270,top_side_length:250,position:20).show.rotate(z:-90,y:180).translate(x:32,y:30,z:25-7)
    
   
  #  axis += motor
   
		axis += XAxisMountingPart.new.show.translate(x:-6,y:-30,z:30)
		axis += XAxisAcmeNutHolder.new.show.translate(x:-6,y:-30,z:30)

		# left side
		axis += XAxisMountingPart.new.show.mirror(x:1).translate(x:306,y:-30,z:30)
		# FIXME: uh, this one is not right		
		axis += XAxisAcmeNutHolder.new.show.mirror(x:1).translate(x:306,y:-30,z:30)



   end
end

