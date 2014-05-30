class XEndMotor < CrystalScad::Printed
	
	def show
		res = import("import/x-end_03.stl")
		res = res.rotate(z:180)

    m = Nema17.new
    res += m.show.rotate(y:-90).translate(x:42,y:-37,z:30)
     
    res 
	end

end
