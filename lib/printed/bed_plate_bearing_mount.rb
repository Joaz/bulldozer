
class BedPlateBearingMount < CrystalScad::Assembly
    attr_accessor :holder_length, :rod_position_x, :rod_position_z
    
    def initialize
      @side_thickness_x = 1
      @side_thickness_y = 2
      @side_thickness_base = @side_thickness_x
      @side_thickness_screw_wall = 3
      @rod_diameter=12
      @plate_thickness=12
      @length_margin=0.3
      @diameter_margin=0.05
            
      @bearing=Lm_uu.new(inner_diameter:@rod_diameter)
      @diameter, @length = @bearing.dimensions
      @length+=@length_margin
      @diameter+=@diameter_margin
         
      @holder_length = @length+@side_thickness_y*2
      @holder_height = @diameter+@side_thickness_base
      @base = cube([@diameter+@side_thickness_x*2, @holder_length, @holder_height])      
      @rod_position_x = @base.x/2
      @rod_position_z = -@plate_thickness
       
    end
    
    def show
      part(true)
    end
    
    def output
      part(false)
    end
    
    def part(show)
     

      part = @base 
      # extend for wood screw that goes under the bed
      part+= cube([10,@holder_length,@holder_height]).translate(x:@diameter+@side_thickness_x*2)
      
      bearing_cut = cylinder(d:@diameter,h:@length).rotate(x:90).translate(x:@base.x/2,y:@base.y-@side_thickness_y)
      bearing_cut2 = cylinder(d:@diameter,h:@length).rotate(x:90).translate(x:@base.x/2,y:@base.y-@side_thickness_y,z:@diameter/2)
    
      part -= hull(bearing_cut,bearing_cut2).translate(z:@side_thickness_base+@diameter/2)
      part -= cylinder(d:@rod_diameter*1.3,h:@length+@side_thickness_y*2+0.2).rotate(x:-90).translate(x:@base.x/2,y:-0.1,z:@side_thickness_base+@diameter/2) 
      # side mount wall
      part += cube([@side_thickness_screw_wall, @holder_length, @plate_thickness+@holder_height]).translate(x:-@side_thickness_screw_wall)
      part -= WoodScrew.new.output.rotate(y:90).translate(x:-@side_thickness_screw_wall-0.1,y:@holder_length/3,z:@holder_height+@plate_thickness/2)
      part -= WoodScrew.new.output.rotate(y:90).translate(x:-@side_thickness_screw_wall-0.1,y:@holder_length/3*2,z:@holder_height+@plate_thickness/2)
 
      part -= WoodScrew.new(length:30).output.rotate(y:0).translate(x:@holder_length-7.5,y:@holder_length/2,z:-0.1)
      
      part += @bearing.show.rotate(x:90).translate(x:@base.x/2,y:@base.y-@side_thickness_y,z:@side_thickness_base+@diameter/2) if show
      part = part.color(@@printed_color)
      # return it with flat part that goes onto the plate = z:0
      return part.translate(z:-@holder_height/2)
      
    end
    
end
