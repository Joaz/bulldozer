
class BulldozerMotor < CrystalScad::Assembly

  def part(show)
    motor = Nema17.new(motor_flange_output_height:20)   
    
    g1 = Gear.new(module:0.5,teeth:14,bore:5,height:6,hub_dia:9,hub_height:6)
    g2 = Gear.new(module:0.5,teeth:80,bore:5,height:4,hub_dia:20,hub_height:4,output_margin_height:5)
    

		res = cube([42,42,5]).center_xy
		res += cube([60,42,20]).center_xy.translate(x:18)

		bolts = create_bolts("top",res,motor,height:6,bolt_height:25)
		res -= bolts
		res += bolts if show

		res -= motor.output.translate(z:-motor.args[:length])
    res += motor.show.translate(z:-motor.args[:length]) if show
    
    res += g1.show.mirror(z:1).translate(z:17)
		res = res.translate(x:-g1.distance_to(g2))

		acme = AcmeRod.new
		bearing = Bearing.new(type:625,output_margin_height:3)
	
		shaft = [bearing,Washer.new(5.3),g2,Washer.new(5.3),acme]	
		offset = [-6,-1,0,8,-3]

		shaft.each_with_index do |item,i|
			res -= item.output.translate(z:12+offset[i])
			res += item.show.translate(z:12+offset[i]) if show
		end		

		res

  end
  


end
