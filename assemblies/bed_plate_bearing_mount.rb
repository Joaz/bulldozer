
class BedPlateBearingMount
    
    def show
      output
    end
    
    def output
      side_thickness_x = 1
      side_thickness_y = 2
      side_thickness_base = side_thickness_x
      side_thickness_screw_wall = 3
      rod_diameter=12
      plate_thickness=12
      length_margin=0.2
      diameter_margin=0.05
      
      bearing=Lm_uu.new(inner_diameter:rod_diameter)
      diameter, length = bearing.dimensions
      length+=length_margin
      diameter+=diameter_margin
         
      holder_length = length+side_thickness_y*2
      holder_height = diameter+side_thickness_base
      
      base = cube([diameter+side_thickness_x*2, holder_length, holder_height])      
      
      part = base 
      
      bearing_cut = cylinder(d:diameter,h:length).rotate(x:90).translate(x:base.x/2,y:base.y-side_thickness_y)
      bearing_cut2 = cylinder(d:diameter,h:length).rotate(x:90).translate(x:base.x/2,y:base.y-side_thickness_y,z:diameter/2)
    
      part -= hull(bearing_cut,bearing_cut2).translate(z:side_thickness_base+diameter/2)
      part -= rod(length+side_thickness_y*2+0.2,size=rod_diameter*1.2).translate(x:base.x/2,y:-0.1,z:side_thickness_base+diameter/2) 
      # side mount wall
      part += cube([side_thickness_screw_wall, holder_length, plate_thickness+holder_height]).translate(x:-side_thickness_screw_wall)
      part -= Bolt.new(3,20).output.rotate(y:90).translate(x:-side_thickness_screw_wall,y:holder_length/3,z:holder_height+plate_thickness/2)
      part -= Bolt.new(3,20).output.rotate(y:90).translate(x:-side_thickness_screw_wall,y:holder_length/3*2,z:holder_height+plate_thickness/2)
      
      assembly = bearing.show.rotate(x:90).translate(x:base.x/2,y:base.y-side_thickness_y,z:side_thickness_base+diameter/2)
      assembly+=part.color(@@printed_color)
      
    end
    
end
