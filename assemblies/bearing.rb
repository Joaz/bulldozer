# this should go to crystalscad standard library
class Bearing
  attr_accessor :size
  def initialize(args={})		
    @args = args
    @args[:type] ||= "608"
    @args[:sealing] ||= "ZZ"
    @args[:margin] ||= 0.0
    @args[:outer_rim_cut] ||= 0.0
    
    
    prepare_data
      
    @@bom.add(description) unless args[:no_bom] == true
  end
  
  def prepare_data
    chart = {"608" => {inner_diameter:8,outer_diameter:22,thickness:7},
             "625" => {inner_diameter:5,outer_diameter:16,thickness:5, inner_rim:7.5, outer_rim:13.5},
    
    
    }
    @size = chart[@args[:type]]
  end
  
  def description
    "Bearing " + @args[:type].to_s + @args[:sealing].to_s
  end
  
  def output
     bearing = cylinder(d:@size[:outer_diameter]+@args[:margin],h:@size[:thickness])
     bearing+= cylinder(d:@size[:outer_rim],h:@args[:outer_rim_cut]).translate(z:-@args[:outer_rim_cut]/2) 
     bearing
  end
  
  def show
    if @size[:inner_rim] && @size[:outer_rim]
      bearing = cylinder(d:@size[:outer_diameter],h:@size[:thickness])
      bearing-= cylinder(d:@size[:outer_rim],h:@size[:thickness]+0.2).translate(z:-0.1)
      bearing = bearing.color("Silver")
      
      bearing+= cylinder(d:@size[:outer_rim],h:@size[:thickness]-0.4).translate(z:0.2).color("PaleGoldenrod")
      bearing+= cylinder(d:@size[:inner_rim],h:@size[:thickness]).color("Silver")
      bearing-= cylinder(d:@size[:inner_diameter],h:@size[:thickness]+0.2).translate(z:-0.1).color("Silver")
      
         
    else
      # simple version
      bearing = cylinder(d:@size[:outer_diameter],h:@size[:thickness])
      bearing-= cylinder(d:@size[:inner_diameter],h:@size[:thickness]+0.2).translate(z:-0.1)    
      bearing.color("LavenderBlush")
    end  
    bearing
  end
    	  
end
