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
    res -= hull(circle(d:10),circle(d:10).translate(x:15)).translate(x:@x/2+40,y:@y-45)

    res -= circle(d:4.4).translate(x:@x/2+40,y:@y-45-10)
    res -= circle(d:4.4).translate(x:@x/2+40,y:@y-45+10)

    res -= circle(d:4.4).translate(x:@x/2+40+15,y:@y-45-10)
    res -= circle(d:4.4).translate(x:@x/2+40+15,y:@y-45+10)
    
    
    # cutouts for the belt holder, M4, 55mm apart    
    res -= circle(d:4.4).translate(x:@x/2+55/2.0,y:@y/2)
    res -= circle(d:4.4).translate(x:@x/2-55/2.0,y:@y/2)
    
    # cutouts for the y bearing holders, M4, 30mm apart      
    res -= circle(d:4.4).translate(x:6.5,y:@y/2)
    res -= circle(d:4.4).translate(x:6.5+30,y:@y/2)

    res -= circle(d:4.4).translate(x:@x-6.5,y:52)
    res -= circle(d:4.4).translate(x:@x-6.5-30,y:52)

    res -= circle(d:4.4).translate(x:@x-6.5,y:@y-52)
    res -= circle(d:4.4).translate(x:@x-6.5-30,y:@y-52)

 
    
    res
  end 
  
  def show
    res = output.linear_extrude(h:@z).color(r:60,b:60,g:60)
  

  end
  
  
  

end
