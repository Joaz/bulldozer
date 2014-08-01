class BottomPlate < CrystalScad::Assembly

  def initialize(args={})
    @args=args
    @args[:tslot_x] ||= 295
		@args[:tslot_y] ||= 470
    @args[:distance_x] ||= 75
    @args[:distance_y] ||= 70
    @args[:tslot_center] ||= 15
  end

  def part(show)
    
    res = cube(x:@args[:tslot_x],y:@args[:tslot_y],z:1).translate(z:4) 
    
    offset_x = (@args[:tslot_x] % @args[:distance_x])
    offset_y = (@args[:tslot_y] % @args[:distance_y])
    
    (@args[:tslot_x].to_i / @args[:distance_x]).times do |x|
      b = Bolt.new(4,16)
      res -= b.translate(x:offset_x+x*@args[:distance_x], y:@args[:tslot_center])            
      b = Bolt.new(4,16)
      res -= b.translate(x:offset_x+x*@args[:distance_x], y:@args[:tslot_y]-@args[:tslot_center])            
    end

    (@args[:tslot_y].to_i / @args[:distance_y]).times do |y|
      b = Bolt.new(4,16)
      res -= b.translate(x:@args[:tslot_center], y:offset_y+y*@args[:distance_y])            
      b = Bolt.new(4,16)
      res -= b.translate(x:@args[:tslot_x]-@args[:tslot_center], y:offset_y+y*@args[:distance_y])            
    end

  
    # additional 4 holes
    
    b = Bolt.new(4,16)
    res -= b.translate(x:@args[:tslot_center], y:@args[:tslot_center])            
    b = Bolt.new(4,16)
    res -= b.translate(x:@args[:tslot_x]-@args[:tslot_center], y:@args[:tslot_center])            
    b = Bolt.new(4,16)
    res -= b.translate(x:@args[:tslot_center], y:@args[:tslot_y]-@args[:tslot_center])            
    b = Bolt.new(4,16)
    res -= b.translate(x:@args[:tslot_x]-@args[:tslot_center], y:@args[:tslot_y]-@args[:tslot_center])            
    

    res = res.projection(cut:true)
    res
  end 

end
