class SpoolHolder < CrystalScad::Assembly
	
	def initialize(args={})
		super
		@rotation = args[:rotation] || 90
		@h1,@h2 = TslotHinge.new,TslotHinge.new
		
		# for the BOM 
		# FIXME no bolts yet
		4.times{
			# those hinges are sadly only available as M6
			TSlotNut.new(bolt_size:6)
		}

		@z_pos=140
	end

	def part(show)
		res = tslots
		
		res += @h1.part_left
		res += @h2.part_left.translate(z:@z_pos)
		res.rotate(x:90,z:-90)
	end

	def tslots
		tslot1 = TSlot.new(size:30,length:@length=320).hole(side:"y",position:"back")
		tslot2 = TSlot.new(size:30,length:@length).hole(side:"y",position:"back")
		res = tslot1.show.rotate(y:90).mirror(z:1).translate(x:7,y:-30-2)
		res += tslot2.show.rotate(y:90).mirror(z:1).translate(x:7,y:-30-2,z:@z_pos)

		res += @h1.part_right
		res += @h2.part_right.translate(z:@z_pos)

		spool = Spool300mm.new
		res += spool.show.translate(x:@length-15+7,y:-15-2,z:34)
		res.rotate(z:-@rotation)
	end

end
