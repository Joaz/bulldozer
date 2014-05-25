class XEndMotor < CrystalScad::Printed
	
	def show
		res = import("import/x-end_03.stl")
		res = res.rotate(z:180)

	end

end
