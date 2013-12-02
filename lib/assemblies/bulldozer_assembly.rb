class BulldozerAssembly < CrystalScad::Assembly

  def show
  	output.translate(x:300,y:110,z:30)  
  end
  
  def output
		tslot = TSlot.new(size:30, configuration:2)
    res = tslot.show(360).rotate(z:90).translate(z:30).color("silver")

		tslot_pusher = TSlot.new(size:30, configuration:2)
		res += tslot.show(230).rotate(x:90).rotate(y:90).translate(x:-60,y:120,z:30).color("silver")

		res += Rod.new(length:380).show.rotate(z:-90).translate(x:-330,y:-15,z:380)
		res += Rod.new(length:380).show.rotate(z:-90).translate(x:-330,y:45,z:380)
		res += Rod.new(length:380).show.rotate(z:-90).translate(x:-330,y:-130,z:15)

		res += BulldozerFrameAssembly.new.show

		res	
	end

  
end
