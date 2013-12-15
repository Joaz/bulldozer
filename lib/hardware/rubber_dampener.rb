class RubberDampener < CrystalScad::Assembly
	#	http://www.rc-force.de/Gummipuffer-Typ-B-M8-R-25-H-15

	# could use a 30mm one, but let's leave a bit of space to assemble it in the dual tslot
	def show
		dia = 25
		height= 15
		res = cylinder(d:dia,h:height).color("black")
		res+= cylinder(d:8,h:20).translate(z:height).color("Silver")
		res-= cylinder(d:8,h:3).color("Silver")
		res
	end

end
