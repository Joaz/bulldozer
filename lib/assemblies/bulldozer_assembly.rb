class BulldozerAssembly < CrystalScad::Assembly
	
	def initialize(args={})
		super
		@height = 375
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

		rod_x = -358
		# these are verified
		res += Rod.new(length:405).show.rotate(z:-90).translate(x:rod_x,y:-15,z:@height+rod_height=18)
		res += Rod.new(length:405).show.rotate(z:-90).translate(x:rod_x,y:45,z:@height+rod_height)
		
		res += BulldozerGearbox.new.show.rotate(y:90).rotate(x:-90).translate(x:-363,y:15,z:height+48)
		res += BulldozerIdler.new.show.rotate(y:90).rotate(x:-90).mirror(x:1).translate(x:60,y:15,z:height+48)
		res += BulldozerAcmeNutHolder.new.show.rotate(y:-90).translate(x:-@position+30,y:15,z:height+48)

	
		res += BulldozerArmBearingSupport.new.show.rotate(y:-90).translate(x:-@position+30,y:-117,z:-13)

		res	
	end

  
end
