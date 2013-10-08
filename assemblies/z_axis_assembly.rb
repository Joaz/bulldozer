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
    #  assembly += tslot_top.show(@args[:right_pos]-@args[:left_pos]).rotate(y:90).translate(x:@args[:left_pos],y:@args[:position],z:@args[:height]-30).color("Silver")
  
      assembly += z_axis_drive
      assembly
  end
  
  def z_axis_drive
		assembly = ZMotorMount.new.show.translate(x:@args[:left_pos],y:@args[:position]-3,z:-60)
    #assembly += Nema17.new.show.translate(x:@args[:left_pos]+4,y:@args[:position]-25,z:-40)
#    assembly += Nema17.new.show.translate(x:@args[:right_pos]-4,y:@args[:position]-25,z:-40)
    
		assembly += AcmeRod.new.show.translate(x:@args[:left_pos]+4,y:@args[:position]-27,z:32)
    assembly += AcmeRod.new.show.translate(x:@args[:right_pos]-4,y:@args[:position]-27,z:32)
    assembly += Coupling.new.show.translate(x:@args[:left_pos]+4,y:@args[:position]-27,z:15)
    assembly += Coupling.new.show.translate(x:@args[:right_pos]-4,y:@args[:position]-27,z:15)
    
		# endstop
		assembly += MicroswitchD3V.new.show.translate(x:@args[:left_pos]-20,y:@args[:position]-15,z:65)

    assembly
  end
  
end
