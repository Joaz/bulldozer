class Spool300mm < CrystalScad::Assembly
	def initialize(args={})
	end

	def show
		res = cylinder(d:300,h:4)
		res += cylinder(d:200,h:100-4).translate(z:4)
		res += cylinder(d:300,h:4).translate(z:100)
		
		res -= cylinder(d:55,h:120).translate(z:-1)

		res.color("DimGrey")
	end
	
	def output
		show
	end

end
