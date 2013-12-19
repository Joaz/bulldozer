class Spool500mm < CrystalScad::Assembly
	def initialize(args={})
	end

	def show
		res = cylinder(d:500,h:12)
		res += cylinder(d:200,h:104).translate(z:12) # TODO : verify core dia
		res += cylinder(d:500,h:12).translate(z:104)
		
		res -= cylinder(d:56.1,h:120).translate(z:-1)

		res.color("DimGrey")
	end
	
	def output
		show
	end

end
