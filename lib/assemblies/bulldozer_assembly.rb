class BulldozerAssembly < CrystalScad::Assembly
	
	def initialize(args={})
		super
		@height = 370
		@position = 0
	end

  def show
  	output.translate(x:300,y:110,z:30)  
  end
  
  def output
		tslot = TSlot.new(size:30, configuration:2)
    res = tslot.show(@height).rotate(z:90).translate(x:30-@position,z:30)

		tslot_pusher = TSlot.new(size:30, configuration:2)
		res += tslot.show(230).rotate(x:90).rotate(y:90).translate(x:-30-@position,y:120,z:30)

		rod_x = -360
		res += Rod.new(length:405).show.rotate(z:-90).translate(x:rod_x,y:-15,z:@height+20)
		res += Rod.new(length:405).show.rotate(z:-90).translate(x:rod_x,y:45,z:@height+20)
		res += Rod.new(length:405).show.rotate(z:-90).translate(x:rod_x,y:-130,z:15)

		
		res += AcmeRod.new.show.rotate(y:90).translate(x:rod_x+15,y:15,z:height+45)
		res += AcmeNut.new.show.rotate(y:90).translate(x:@position-10,y:15,z:height+45)

		res += Lm_luu.new(inner_diameter:12).show.rotate(y:90).translate(x:@position-28,y:-15,z:height+20)
		res += Lm_luu.new(inner_diameter:12).show.rotate(y:90).translate(x:@position-28,y:-15+60,z:height+20)


		res	
	end

  
end
