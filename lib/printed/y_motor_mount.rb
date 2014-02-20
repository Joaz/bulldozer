class YMotorMount < CrystalScad::Assembly
  

  
  def part(show)
    motor_mount = MotorMount.new(thickness:z=26,bolt_height:30)
    res += motor_mount.part(show)
		res += cube([x1=10,20,z]).center_x.translate(x:-42/2.0+x1/2,y:9+10).color(@@printed_color)
		res += cube([x2=2,60,z]).center_x.translate(x:-42/2.0+x2/2-1,y:-42/2).color(@@printed_color)
	  res -= cube([5,10,z+0.1]).translate(x:-13,y:-10)
	  res -= cube([5,3,z+0.1]).translate(x:-10,y:-10)
	  
	  bolt = Bolt.new(4,16,washer:true)
    nut = TSlotNut.new
	  res -= bolt.output.rotate(y:-90).translate(x:-13,y:-6,z:16)  
	  res += bolt.show.rotate(y:-90).translate(x:-13,y:-6,z:16) if show
	  res += nut.show.mirror(z:1).rotate(y:-90).translate(nut.threads_top.position_on(bolt)).translate(x:-13-8,y:-6,z:16) if show


	  bolt = Bolt.new(4,16,washer:true)
    nut = TSlotNut.new
	  res -= bolt.output.rotate(y:-90).translate(x:-11,y:-6+30,z:16)  
	  res += bolt.show.rotate(y:-90).translate(x:-11,y:-6+30,z:16) if show
	  res += nut.show.mirror(z:1).rotate(y:-90).translate(nut.threads_top.position_on(bolt)).translate(x:-13-8,y:-6+30,z:16) if show

			 
    res
  end

  
end
