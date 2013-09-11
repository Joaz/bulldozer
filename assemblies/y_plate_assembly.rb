class YPlateAssembly
  def initialize(args={})
    @args = args
    @args[:length] ||= 500
    @args[:rod_size] ||= 12    
    @args[:position] ||= 150 
    @args[:bed_size_x] ||= 225
    @args[:bed_size_y] ||= 225       
    @args[:bed_size_z] ||= 12
  end
  
  def show
    bed_plate=BedPlate.new(x:@args[:bed_size_x],y:@args[:bed_size_y],z:@args[:bed_size_z])
    holder_left=BedPlateBearingMount.new
    fixed = Rod.new(length:@args[:length]).show.translate(x:holder_left.rod_position_x,z:holder_left.rod_position_z)   
    fixed += Rod.new(length:@args[:length]).show.translate(x:@args[:bed_size_x]-holder_left.rod_position_x,z:holder_left.rod_position_z)      
    
    moving_table = holder_left.output.translate(x:0,z:-@args[:bed_size_z],y:(@args[:bed_size_y]-holder_left.holder_length)/2)          
    # holders on the right side
    moving_table += BedPlateBearingMount.new.output.mirror(x:1).translate(x:@args[:bed_size_x],z:-@args[:bed_size_z],y:(@args[:bed_size_y]-holder_left.holder_length)/5)          
    moving_table += BedPlateBearingMount.new.output.mirror(x:1).translate(x:@args[:bed_size_x],z:-@args[:bed_size_z],y:(@args[:bed_size_y]-holder_left.holder_length)/5*4)          
   
    moving_table += bed_plate.show.translate(z:-1)
    assembly = fixed + moving_table.translate(y:@args[:position])
    
  end

end
