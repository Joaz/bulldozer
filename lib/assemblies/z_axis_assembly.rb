class ZAxisAssembly < CrystalScad::Assembly
  def initialize(args={})
    @args = args
    @args[:position] ||= 280
    @args[:left_pos] = -30  # left of y t-slot
    @args[:right_pos] = 325 # right of y-tslot
    @args[:height] = 470 # total height from bottom
    @args[:tslot_simple] ||= false
  end
 
  def show
      tslot_left = TSlotMachining.new(size:30,configuration:2,holes:"front",bolt_size:5,bolt_length:30,simple:@args[:tslot_simple])
      tslot_right = TSlotMachining.new(size:30,configuration:2,holes:"front",bolt_size:5,bolt_length:30,simple:@args[:tslot_simple])
      tslot_top = TSlotMachining.new(size:30,configuration:2,holes:"front,back",bolt_size:8,bolt_length:30,simple:@args[:tslot_simple])
  
      assembly = tslot_left.show(@args[:height]).translate(x:@args[:left_pos],y:@args[:position],z:-60).color("Silver")
      assembly += tslot_right.show(@args[:height]).mirror(x:1).translate(x:@args[:right_pos],y:@args[:position],z:-60).color("Silver")
      assembly += tslot_top.show(@args[:right_pos]-@args[:left_pos]).rotate(y:90).translate(x:@args[:left_pos],y:@args[:position],z:@args[:height]-30).color("Silver")
  
      assembly += z_axis_drive

      assembly
  end
  
  def z_axis_drive
		assembly = ZMotorMount.new.show.translate(x:@args[:left_pos],y:@args[:position]-3,z:-60)
		assembly += ZMotorMount.new.show.mirror(x:1).translate(x:@args[:right_pos],y:@args[:position]-3,z:-60)

		assembly += ZAcmeBearingHolderLower.new.show.rotate(z:180).translate(x:@args[:left_pos]+30,y:@args[:position],z:42)
		assembly += ZAcmeBearingHolderLower.new.show(false).mirror(x:1).rotate(z:180).translate(x:@args[:right_pos]-30,y:@args[:position],z:42)

		assembly += ZAcmeBearingHolderUpper.new.show.rotate(z:180).mirror(z:1).translate(x:@args[:left_pos]+30,y:@args[:position],z:410)
		assembly += ZAcmeBearingHolderUpper.new.show.mirror(x:1).rotate(z:180).mirror(z:1).translate(x:@args[:right_pos]-30,y:@args[:position],z:410)
    
    
		assembly += AcmeRod.new(top_bearing_offset:-16).show.translate(x:@args[:left_pos]+4,y:@args[:position]-27,z:32)
    assembly += AcmeRod.new(top_bearing_offset:-16).show.translate(x:@args[:right_pos]-4,y:@args[:position]-27,z:32)
    assembly += Coupling.new.show.translate(x:@args[:left_pos]+4,y:@args[:position]-27,z:15)
    assembly += Coupling.new.show.translate(x:@args[:right_pos]-4,y:@args[:position]-27,z:15)

    rod_position_left = 18
    rod_position_right = @args[:right_pos]-30-18
    
    assembly += Rod.new(length:405).show.rotate(x:90).translate(y:@args[:position]+2+50,x:rod_position_left,z:2)
    assembly += Rod.new(length:405).show.rotate(x:90).translate(y:@args[:position]+2+50,x:rod_position_right,z:2)
    # bottom
    assembly += ZRodHolder.new.show.rotate(z:90).translate(y:@args[:position]+30,x:rod_position_left-13,z:0)
    assembly += ZRodHolder.new.show.mirror(y:1).rotate(z:90).translate(y:@args[:position]+30,x:rod_position_right+13,z:0)
    # top
    assembly += ZRodHolder.new.show.mirror(z:1).rotate(z:90).translate(y:@args[:position]+30,x:rod_position_left-13,z:@args[:height]-60)
    assembly += ZRodHolder.new.show.mirror(z:1).mirror(y:1).rotate(z:90).translate(y:@args[:position]+30,x:rod_position_right+13,z:@args[:height]-60)

	
    assembly
  end
  
end
