class YPlate < CrystalScad::Assembly

	def initialize(args={})
		@x = args[:x] || 226				
		@y = args[:y] || 226				
		@z = args[:z] || 3	
    
    
  end


  def output
    res = square([@x,@y])
    # substract holes for heatbed
    bed =Heatbed.new(no_bom:true)
    bed.hole_positions.each do |pos|
      pos_x,pos_y = pos[:x],pos[:y]
      res -= circle(d:3.2).translate(x:(@x-bed.x)/2.0 + pos_x,y:(@y-bed.y)/2.0 + pos_y)
    end
    
    # cutout for wires to go through
    res -= hull(circle(d:10),circle(d:10).translate(x:30)).translate(x:@x/2-15,y:@y-40)
    # FIXME: make hole for zip ties
    # check where the wires exit
    
    res
  end 
  
  def show
    res = output.linear_extrude(h:@z).color(r:60,b:60,g:60)
  

  end
  
  
  

end
