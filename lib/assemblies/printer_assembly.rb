class PrinterAssembly < CrystalScad::Assembly

	def show
		res = YAxisAssembly.new.show
		res += ZAxisAssembly.new.show
		res += YzBracket.new.show.rotate(y:90,z:90).translate(y:310)

	end

end
