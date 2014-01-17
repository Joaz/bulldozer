class XAxisAssembly < CrystalScad::Assembly
  def initialize(args={})
    @args=args
    @args[:position] ||= 15+0
  end
  
  def show
    # z bearings
    axis  = ZLinearBearingHolder.new(inner_diameter:12).show.translate(x:17.5,y:44,z:-43)
    axis += ZLinearBearingHolder.new(inner_diameter:12).show(false).mirror(x:1).translate(x:282.5,y:44,z:-43)
   # axis += Lm_uu.new(inner_diameter:12).rotate(x:0).translate(y:43,x:17.5,z:35)
    
    #axis += Lm_uu.new(inner_diameter:12).rotate(x:0).translate(y:43,x:17.5+265,z:-50)
   # axis += Lm_uu.new(inner_diameter:12).rotate(x:0).translate(y:43,x:17.5+265,z:35)

    axis += TSlot.new(size:30).length(300).thread.thread(position:"back").show.rotate(y:90).color("Silver")
    axis += Rod.new(length:307).show.rotate(z:-90).translate(y:15,z:15,x:-3.5)
    axis += Rod.new(length:307).show.rotate(z:-90).translate(y:-15,z:-15,x:-3.5)

    axis += XCarriage.new().show.rotate(y:90).translate(x:1+@args[:position],y:-30,z:30) 
	#	axis += MGS_Old.new.show.rotate(z:180).translate(x:1+@args[:position]+74.5,y:-51,z:-15.25) 
   	axis += MGS.new.show.rotate(x:90).rotate(y:90,z:-90).translate(x:1+@args[:position]+70.5-7,y:-61,z:7) 
		axis += XAxisMountingPart.new.show.translate(x:-6,y:-30,z:30)
		axis += XAxisAcmeNutHolder.new.show.translate(x:-6,y:-30,z:30)

		# left side
		axis += XAxisMountingPart.new.show.mirror(x:1).translate(x:306,y:-30,z:30)
		axis += XAxisAcmeNutHolder.new.show.mirror(x:1).translate(x:306,y:-30,z:30)


    axis.translate(y:-42)
   end
end

