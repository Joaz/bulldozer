class ZAxisAssembly
  def initialize(args={})
    @args = args
    @args[:position] ||= 280
    @args[:left_pos] = -30  # left of y t-slot
    @args[:right_pos] = 325 # right of y-tslot
    @args[:height] = 450 # total height from bottom
    
  end
 
  def show
      tslot_left = TSlotMachining.new(size:30,configuration:2,holes:"front",bolt_size:8,bolt_length:30)
      tslot_right = TSlotMachining.new(size:30,configuration:2,holes:"front",bolt_size:8,bolt_length:30)
      tslot_top = TSlotMachining.new(size:30,configuration:2,holes:"front,back",bolt_size:8,bolt_length:30)
  
      assembly = tslot_left.show(@args[:height]).translate(x:@args[:left_pos],y:@args[:position],z:-60).color("Silver")
      assembly += tslot_right.show(@args[:height]).mirror(x:1).translate(x:@args[:right_pos],y:@args[:position],z:-60).color("Silver")
      assembly += tslot_top.show(@args[:right_pos]-@args[:left_pos]).rotate(y:90).translate(x:@args[:left_pos],y:@args[:position],z:@args[:height]-30).color("Silver")
  
      assembly
  end
  
end
