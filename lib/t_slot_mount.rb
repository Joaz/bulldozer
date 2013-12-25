class TSlotMount < CrystalScad::Assembly


	def initialize(args={})
		@additional_wall_length=args[:additional_wall_length] || 0
		@peg = args[:peg] || true
		@peg_style = args[:peg_style] || 0
	end

  def part(show)
    res = cube([30+@additional_wall_length,5,30]).color(@@printed_color)	
    if @peg
			res += peg.translate(x:11,y:-5).color(@@printed_color) 	
		end
		res -= long_slot(d:4.4,h:10,l:14).rotate(y:90,z:90).translate(x:15,y:-3,z:25)
		bolt = Bolt.new(4,12)
		washer = Washer.new(4.3)		
		res += bolt.show.rotate(x:90).translate(x:15,y:6,z:20) if show
		res += washer.show.rotate(x:90).translate(x:15,y:6,z:20) if show
    res
  end

	def peg
		return cube([8,5,5]) if @peg_style == 0
		return hull(cube([8,5,3]),cube([8,1,1]).translate(y:5,z:7.5))if @peg_style == 1
	
	end	

end
