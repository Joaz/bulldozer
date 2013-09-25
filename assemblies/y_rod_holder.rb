class YRodHolder < CrystalScad::Assembly

	def show
		part(true)
	end

	def output
		res = part(false)
		res+= part(false).mirror(x:1).translate(y:27)
	end

	def part(show)
		res = cube([50,17+6,6]).center_xy.translate(y:-5) 
		res += cylinder(d:17,h:20).translate(x:-8.5)
    res -= cylinder(d:12.7,h:20).translate(x:-8.5,z:2.5)
		res = res.color(@@printed_color)

		bolt = Bolt.new(4,12)
		washer = Washer.new(4.3)

		res -= hull(cylinder(d:4.4,h:4),cylinder(d:4.4,h:4).translate(x:15)).translate(x:5,y:-6.5,z:-0.1)			
		res += bolt.show.rotate(x:180).translate(x:15,y:-6.5,z:7) if show
		res += washer.show.rotate(x:180).translate(x:15,y:-6.5,z:7) if show

		res
	end
	

end

