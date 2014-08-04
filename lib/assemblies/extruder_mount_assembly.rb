class ExtruderMountAssembly < CrystalScad::Assembly

	def initialize(args={})

	end

	def part(show)
		res = ExtruderMountBase.new.show
	end

end
