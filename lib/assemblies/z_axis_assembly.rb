class ZAxisAssembly < CrystalScad::Assembly
  def initialize(args={})
    @args = args
    @args[:position] ||= 280
    @args[:left_pos] = -30  # left of y t-slot
    @args[:right_pos] = 325 # right of y-tslot
    @args[:height] = 483 # total height from bottom
    @args[:tslot_simple] ||= false
  end
 
  def show
      tslot_left = TSlot.new(size:30,configuration:2,simple:@args[:tslot_simple]).hole(side:"y",position:"front").thread(position:"back")
      tslot_right = TSlot.new(size:30,configuration:2,simple:@args[:tslot_simple]).hole(side:"y",position:"front").thread(position:"back")
      tslot_top = TSlot.new(size:30,configuration:2,simple:@args[:tslot_simple]).length(@args[:right_pos]-@args[:left_pos]).hole(side:"y",position:"front").hole(side:"y",position:"back")
  
      assembly = tslot_left.length(@args[:height]).show.translate(x:@args[:left_pos],z:-60)
      assembly += tslot_right.length(@args[:height]).show.mirror(x:1).translate(x:@args[:right_pos],z:-60)
      assembly += tslot_top.show.rotate(y:90).translate(x:@args[:left_pos],z:@args[:height]-30)


      assembly += bolts.translate(x:@args[:left_pos])
      assembly += bolts.mirror(x:1).translate(x:@args[:right_pos])
  
      assembly += z_axis_drive

      assembly.translate(y:@args[:position])
  end

	def bolts
    		
		res = nil
		(0..1).each do |i|		
			# lower bolts
		
			b = Bolt.new(8,40,washer:true)
			t = TSlotNut.new(bolt_size:8)
			res += b.show.rotate(y:90).translate(y:15+30*i,z:-45)
			res += t.show.translate(t.threads_top.position_on(b)).rotate(z:90).rotate(y:90).translate(x:40,y:15+30*i,z:-45)

			# upper bolts
			b = Bolt.new(8,50,washer:true)
			res += b.show.mirror(z:1).translate(x:15,y:15+i*30,z:@args[:height]-30)
		
		end

		res
	end
  
  def z_axis_drive
		assembly = ZMotorMount.new.show.translate(x:@args[:left_pos],y:-3,z:-60)
		assembly += ZMotorMount.new.show.mirror(x:1).translate(x:@args[:right_pos],y:-3,z:-60)

		assembly += ZAcmeBearingHolderLower.new.show.rotate(z:180).translate(x:@args[:left_pos]+30,z:42)
		assembly += ZAcmeBearingHolderLower.new.show(false).mirror(x:1).rotate(z:180).translate(x:@args[:right_pos]-30,z:42)

		assembly += ZAcmeBearingHolderUpper.new.show.rotate(z:180).mirror(z:1).translate(x:@args[:left_pos]+30,z:423)
		assembly += ZAcmeBearingHolderUpper.new.show.mirror(x:1).rotate(z:180).mirror(z:1).translate(x:@args[:right_pos]-30,z:423)
    
    
		assembly += AcmeRod.new(top_bearing_offset:-3).show.translate(x:@args[:left_pos]+4,y:-27,z:32)
    assembly += AcmeRod.new(top_bearing_offset:-3).show.translate(x:@args[:right_pos]-4,y:-27,z:32)
    assembly += Coupling.new.show.translate(x:@args[:left_pos]+4,y:-27,z:15)
    assembly += Coupling.new.show.translate(x:@args[:right_pos]-4,y:-27,z:15)

    rod_position_left = 18
    rod_position_right = @args[:right_pos]-30-18
    
    assembly += Rod.new(length:405).show.rotate(x:90).translate(y:52,x:rod_position_left,z:2)
    assembly += Rod.new(length:405).show.rotate(x:90).translate(y:52,x:rod_position_right,z:2)
    

	# bottom
    assembly += ZRodHolder.new.show.translate(y:60,x:rod_position_left-48,z:0)
    assembly += ZRodHolder.new.show.mirror(x:1).translate(y:60,x:rod_position_right+48,z:0)
    # top
    assembly += ZRodHolder.new.show.mirror(z:1).translate(y:60,x:rod_position_left-48,z:@args[:height]-60)
    assembly += ZRodHolder.new.show.mirror(z:1).mirror(x:1).translate(y:60,x:rod_position_right+48,z:@args[:height]-60)


    assembly
  end
  
end
