class TSlotMount < CrystalScad::Assembly


	def initialize(args={})
		@additional_wall_length=args[:additional_wall_length] || 0
		@peg = args[:peg] 
		@peg = true if @peg == nil
		@peg_style = args[:peg_style] || 0
		@thickness = args[:thickness] || 5
		@bolt_length = args[:bolt_length] || 12
		@bolt_size = args[:bolt_size] || 4
		@bolt_position = args[:bolt_position] || 20

		@slot_length = args[:slot_length] || 14
	end

  def part(show)
    res = cube([30+@additional_wall_length,@thickness,16+@slot_length]).color(@@printed_color)	
    if @peg
			res += peg.translate(x:11,y:-5).color(@@printed_color) 	
		end
		res -= long_slot(d:1.1*@bolt_size,h:@thickness+0.2,l:@slot_length).rotate(y:90,z:90).translate(x:15,y:-0.1,z:8+@slot_length)
		bolt = Bolt.new(@bolt_size,@bolt_length,washer:true)
		res += bolt.show.rotate(x:90).translate(x:15,y:@thickness,z:@bolt_position) if show
		nut = TSlotNut.new(bolt_size:@bolt_size)
		res += nut.show.mirror(z:1).rotate(x:90).translate(nut.threads_top.position_on(bolt)).rotate(y:90).translate(x:15,y:-0,z:@bolt_position) if show

    res
  end

	def peg
		return cube([8,5,5]) if @peg_style == 0
		return hull(cube([8,5,3]),cube([8,1,1]).translate(y:5,z:7.5))if @peg_style == 1
	
	end	

end
