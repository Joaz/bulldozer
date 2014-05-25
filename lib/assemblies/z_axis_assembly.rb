class ZAxisAssembly < CrystalScad::Assembly
  def initialize(args={})
    @args = args
    @args[:position] ||= 280
    @args[:left_pos] = -30  # left of y t-slot
    @args[:right_pos] = 325 # right of y-tslot
    @args[:height] = 483 # total height from bottom
    @args[:tslot_simple] ||= false
		@tslot_configuration = 1

  end
 
	def tslot
		TSlot.new(size:30,configuration:@tslot_configuration,simple:@args[:tslot_simple])	
	end
	
  def show
      tslot_left = tslot.length(@args[:height]).hole(side:"y",position:"front").hole(side:"y",position:45).thread(position:"back")
      tslot_right = tslot.length(@args[:height]).hole(side:"y",position:"front").hole(side:"y",position:45).thread(position:"back")
      tslot_top = tslot.length(@args[:right_pos]-@args[:left_pos]).holes(side:"y")
  
      assembly = tslot_left.show.translate(x:@args[:left_pos],z:-60)
      assembly += tslot_right.show.mirror(x:1).translate(x:@args[:right_pos],z:-60)
      assembly += tslot_top.show.rotate(y:90).translate(x:@args[:left_pos],z:@args[:height]-30)


      assembly += bolts.translate(x:@args[:left_pos])
      assembly += bolts.mirror(x:1).translate(x:@args[:right_pos])
  
      assembly += z_axis_drive

      assembly.translate(y:@args[:position])
  end

	def bolts
    		
		res = nil
		(0..@tslot_configuration-1).each do |i|		
			# lower bolts
		
			b = Bolt.new(8,40,washer:true)
			t = TSlotNut.new(bolt_size:8)
			(0..1).each do |f|			
				res += b.show.rotate(y:90).translate(y:15+30*i,z:-45+30*f)
				res += t.show.translate(t.threads_top.position_on(b)).rotate(z:90).rotate(y:-90).translate(x:30,y:15+30*i,z:-45+30*f)
			end

			# upper bolts
			b = Bolt.new(8,50,washer:true)
			res += b.show.mirror(z:1).translate(x:15,y:15+i*30,z:@args[:height]-30)
		
		end

		res
	end
  
  def z_axis_drive
		assembly = ZMotorMount.new.show.translate(x:@args[:left_pos],y:-3,z:-60)
		assembly += ZMotorMount.new.show.mirror(x:1).translate(x:@args[:right_pos],y:-3,z:-60)
		assembly += XEndMotor.new.show.rotate(z:-90).translate(x:@args[:left_pos]-13,y:-27,z:60)

		# smooth rod center y from threaded rod: x:17,y:-2

#		assembly += ZAcmeBearingHolderLower.new.show.rotate(z:180).translate(x:@args[:left_pos]+30,z:42)
#		assembly += ZAcmeBearingHolderLower.new.show(false).mirror(x:1).rotate(z:180).translate(x:@args[:right_pos]-30,z:42)

#		assembly += ZAcmeBearingHolderUpper.new.show.rotate(z:180).mirror(z:1).translate(x:@args[:left_pos]+30,z:423)
#		assembly += ZAcmeBearingHolderUpper.new.show.mirror(x:1).rotate(z:180).mirror(z:1).translate(x:@args[:right_pos]-30,z:423)
    
    
#		assembly += AcmeRod.new(top_bearing_offset:-3).show.translate(x:@args[:left_pos]+4,y:-27,z:32)
#    assembly += AcmeRod.new(top_bearing_offset:-3).show.translate(x:@args[:right_pos]-4,y:-27,z:32)
    assembly += Coupling.new.show.translate(x:@args[:left_pos]+4,y:-27,z:15)
    assembly += Coupling.new.show.translate(x:@args[:right_pos]-4,y:-27,z:15)

    rod_position_left = 18
    rod_position_right = @args[:right_pos]-30-18
    
    assembly += Rod.new(size:10,length:405).show.rotate(x:90).translate(x:@args[:left_pos]-13,y:-27-2,z:10)
    assembly += Rod.new(size:10,length:405).show.rotate(x:90).translate(y:52,x:rod_position_right,z:2)
    

	# bottom
#    assembly += ZRodHolder.new.show.translate(y:60,x:rod_position_left-48,z:0)
#    assembly += ZRodHolder.new.show.mirror(x:1).translate(y:60,x:rod_position_right+48,z:0)
    # top
#    assembly += ZRodHolder.new.show.mirror(z:1).translate(y:60,x:rod_position_left-48,z:@args[:height]-60)
#    assembly += ZRodHolder.new.show.mirror(z:1).mirror(x:1).translate(y:60,x:rod_position_right+48,z:@args[:height]-60)


    assembly
  end
  
end
