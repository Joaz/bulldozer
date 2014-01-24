class BedPlate < CrystalScad::Assembly
	attr_accessor :size
	def initialize(args={})
		@size=args	

	  @bolt_height = @size[:z]
	  @heatbed_pos = {x:6,y:6,z:18}
	  @heatbed = Heatbed.new
	end
	
	
	def part(show)
	  res = YPlate.new.show

	  res += @heatbed.show.translate(@heatbed_pos)
	  res += bolts.translate(@heatbed_pos)
	  
	  
	end 
	
	def bolts
		res = nil
		@heatbed.hole_positions.each do |pos|
      dbolt = DistanceBoltM4.new.show
      # nuts on the distance bolt
      nut = Nut.new(4)
      dbolt += nut.show.rotate(z:15).translate(z:9)
      nut = Nut.new(4)
      dbolt += nut.show.rotate(z:30).translate(z:9+nut.height)
      # lower bolt
      bolt = Bolt.new(4,8,washer:true)
      dbolt += bolt.show.translate(z:-3)
      
      res += dbolt.translate(x:pos[:x],y:pos[:y],z:-(9+nut.height*2)+0.4)
    end
    res
	end

	

end
