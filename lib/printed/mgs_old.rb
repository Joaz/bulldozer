class MGS_Old < CrystalScad::Printed
	
	def show
		res = import("import/mgs_prusa_i3_fixed.stl")
		res += import("import/mgs_prusa_i3_groovemount.stl").rotate(y:180).translate(z:-16.4)


		res = res.color("white")
		res += JHead.new.show	.translate(x:32,y:5,z:-83)		

	end

end
