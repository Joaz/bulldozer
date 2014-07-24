class XEndMotor < CrystalScad::Printed
	
	def show
		res = import("import/x-end_03.stl")
		res = res.rotate(z:180).translate(x:16,y:27)

    m = Nema17.new
    res += m.show.rotate(y:-90).translate(x:40,y:-36,z:31.5)

		res = res.translate(x:0)     
		
		bearing=Lm_uu.new(inner_diameter:10)
		res += bearing.show.translate(z:2)
		bearing=Lm_uu.new(inner_diameter:10)
		res += bearing.show.translate(z:2+34)


		res += import("import/x-end_02.stl").rotate(z:180).translate(x:16,y:395.5)

		bearing=Lm_uu.new(inner_diameter:10)
		res += bearing.show.translate(y:375,z:2)
		bearing=Lm_uu.new(inner_diameter:10)
		res += bearing.show.translate(y:375,z:2+34)



		rod = Rod.new(size:10,length:405)

		res += rod.show.translate(x:-17.3,y:-10,z:7)

		rod = Rod.new(size:10,length:405)
		res += rod.show.translate(x:-17.3,y:-10,z:7+45)


    res 
	end

end
