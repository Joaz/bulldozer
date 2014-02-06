class YBearingHolder < CrystalScad::Assembly
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
      @holder_height = 42.0/2

    end

    
    def show
      res = half(true)
      res += half(true,false).mirror(z:1).translate(z:@holder_height*2)
      res += @bearing.show.rotate(x:90).translate(y:32,z:@holder_height)
      res.translate(z:-@holder_height) # center on bearing center for show
    end
    
    def output
      res = half(false)
      res += half(false, false).translate(x:43)
      res
    end

   def half(show,bottom=true)
      res = cube([42, @holder_length, @holder_height]).center_x.color(@@printed_color)          
       

      res -= cylinder(d:@diameter,h:@length).rotate(x:90).translate(y:32,z:@holder_height)
      res -= cylinder(d:@rod_diameter*1.3,h:@length+@side_thickness_y*2+0.2).rotate(x:-90).translate(y:-0.1,z:@holder_height) 
      
      

      [1,-1].each do |i|
      
        b = Bolt.new(4,50,washer:true,no_bom:!bottom)
        res -= b.output.rotate(y:0).translate(x:i*15,y:@holder_length/2,z:-0.1)
        res += b.show.rotate(y:0).translate(x:i*15,y:@holder_length/2,z:-0.1) if show and bottom
      end 
      res
   end
    
end

