class BulldozerAssembly < CrystalScad::Assembly
	
	def initialize(args={})
		super
		@height = 365
		@position = args[:position] || 0
	end

  def show
  	output.translate(x:300,y:110,z:30)  
  end
  
  def output
		tslot = TSlot.new(size:30, configuration:2)
    res = tslot.show(@height).rotate(z:90).translate(x:30-@position,z:30)

		tslot_pusher = TSlot.new(size:30, configuration:2)
		res += tslot.show(223).rotate(x:90).rotate(y:90).translate(x:-30-@position,y:120,z:30)

		tslot_rod_support = TSlot.new(size:30, configuration:1)
		res += tslot_rod_support.show(150).translate(x:-370,y:-110,z:-115)

		rod_x = -360
		# FIXME: check if the rod lengths work
		res += Rod.new(length:405).show.rotate(z:-90).translate(x:rod_x,y:-15,z:@height+rod_height=18)
		res += Rod.new(length:405).show.rotate(z:-90).translate(x:rod_x,y:45,z:@height+rod_height)
		#	lower rod
	#	res += Rod.new(length:380).show.rotate(z:-90).translate(x:rod_x+25,y:-104,z:15)

		
		res += BulldozerGearbox.new.show.rotate(y:90).rotate(x:-90).translate(x:rod_x+3,y:15,z:height+48)
		res += BulldozerIdler.new.show.rotate(y:90).rotate(x:-90).mirror(x:1).translate(x:60,y:15,z:height+48)
		res += BulldozerAcmeNutHolder.new.show.rotate(y:-90).translate(x:-@position+30,y:15,z:height+48)

	
		res += BulldozerArmBearingSupport.new.show.rotate(y:-90).translate(x:-@position+30,y:-117,z:-13)
		
		res	
	end

  
end
