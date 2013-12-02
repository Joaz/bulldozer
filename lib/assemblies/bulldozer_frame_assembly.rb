class BulldozerFrameAssembly < CrystalScad::Assembly


	def show
		output.rotate(x:-90).translate(x:-360,y:-140,z:410)
	end

	def output
		tslot_left = TSlot.new(size:30, configuration:1)
 		tslot_right = TSlot.new(size:30, configuration:1)
 		tslot_front = TSlot.new(size:30, configuration:1) 
 		tslot_support = TSlot.new(size:30, configuration:1)
   
		res += tslot_left.show(400)
		res += tslot_right.show(400).translate(x:385)
		res += tslot_front.show(415).rotate(y:90).translate(x:0)
		res += tslot_support.show(470).rotate(x:-90).translate(x:180,y:30)
		

		res.color("Silver")
	end
	

end
