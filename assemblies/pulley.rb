class Pulley < CrystalScad::Assembly
	
	def show
	  res = cylinder(d:15,h:6)
	  res += cylinder(d:12,h:7).translate(z:6)
	  res += cylinder(d:15,h:1).translate(z:13)
	  res -= cylinder(d:5,h:15).translate(z:-0.1)
	  res.color("Silver")
	end

end
