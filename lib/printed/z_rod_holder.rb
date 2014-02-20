class ZRodHolder < CrystalScad::Assembly

	def show
		part(true)
	end

	def output
		res = part(false)
	
		res+= part(false).mirror(x:1).translate(y:-20,x:23)
	end
	
  def tslot_mount(show, additional_wall_length=0)
    res = cube([30+additional_wall_length,y=14,30]).color(@@printed_color)	
    res += cube([8,5,5]).translate(x:11,y:-5).color(@@printed_color)	

		res -= long_slot(d:4.4,h:y+0.2,l:14).rotate(y:90,z:90).translate(x:15,y:-0.1,z:25)
		bolt = Bolt.new(4,20,washer:true)
		
		t = TSlotNut.new(bolt_size:4)
		res += bolt.show.rotate(x:90).translate(x:15,y:y,z:20) if show
		res += t.show.translate(t.threads_top.position_on(bolt)).rotate(x:90).translate(x:15,y:-10,z:20) if show

		res
  end

	def part(show)
    res = tslot_mount(show,5).translate(y:-30) 
   # res += tslot_mount(show).rotate(z:-90).translate(x:30) 
    res += tslot_mount(show).rotate(z:-90).translate(x:30,y:-30) 
     
		res += cube([30,35,30]).translate(x:30,y:-30).color(@@printed_color)	

	  
	  res -= cylinder(d:12.5,h:30).translate(x:30+18,y:-8,z:1.5)


		res
	end	

	def part_(show)
		res = cube([60,25,6]).center_x.translate(x:0,y:-25) 
		res += cube([60,5,5]).center_x.rotate(x:45).translate(y:0,z:2.5)	
	
		res += cube([60,5,40]).center_x 
		res = res.color(@@printed_color)


		2.times do |i|
			res -= long_slot(d:4.4,h:10,l:14).rotate(y:90,z:90).translate(x:15-30*i,y:-3,z:35)
			bolt = Bolt.new(4,12)
			washer = Washer.new(4.3)		
			res += bolt.show.rotate(x:-90).translate(x:15-30*i,y:-1,z:30) if show
			res += washer.show.rotate(x:-90).translate(x:15-30*i,y:-1,z:30) if show

			i+=1 		
		end

		res -= long_slot(d:4.4,h:10,l:25).rotate(y:0,z:0).translate(x:-20,y:-10,z:0)
		bolt = Bolt.new(4,12)
		washer = Washer.new(4.3)		
		res += bolt.show.mirror(z:1).translate(x:-15,y:-10,z:7) if show
		res += washer.show.mirror(z:1).translate(x:-15,y:-10,z:7) if show


		res
	end
	

end

