#!/usr/bin/ruby1.9.3

#while inotifywait -e close_write bulldozer.rb; do ./bulldozer.rb > bulldozer.scad; done


require "rubygems"
require "crystalscad"
require "require_all"

require_all "assemblies"

include CrystalScad


@@printed_color="Bisque"



def tslot_rectangle(x,y,tslot_type_x,tslot_type_y)
	size = tslot_type_x.args[:size]
	# x 
	r = tslot_type_x.show(x-size*2).rotate(x:-90,z:-90).translate(x:size,y:size)
	r += tslot_type_x.show(x-size*2).rotate(x:-90,z:-90).translate(x:size,y:y)   
 
  # y
	r += tslot_type_y.show(y).rotate(x:-90)
	r += tslot_type_y.show(y).rotate(x:-90).mirror(x:1).translate(x:x)
  
  return r.color("Silver")
end





assembly=ScadObject.new



assembly+= YPlateAssembly.new(length:470,rod_size:12,position:100).show.translate(z:3.5,y:30,x:35)
#assembly+=rod(500).translate(x:11.5,z:20.5)
#assembly+=rod(500).translate(x:200+10,z:20)
#assembly+=Lm_uu.new(inner_diameter:12).show.rotate(x:90).translate(x:15,z:20,y:100)

#assembly+=Lm_uu.new(inner_diameter:12).show.rotate(x:90).translate(x:15,z:20,y:200)
#assembly+=Lm_uu.new(inner_diameter:12).show.rotate(x:90).translate(x:210,z:20,y:150)
 
#assembly+=tslot_rectangle(225+60+10,520, TSlot.new(size:30,configuration:2), TSlotMachining.new(size:30,configuration:2,holes:"front,back",bolt_size:8,bolt_length:30))    

class YBeltHolder < CrystalScad::Assembly
  
  def show
		belt_holder(true)
  end

	def output
		belt_holder(false)
	end

	
	def belt_holder_base(with_hardware=false)
	  base = cube([50,10,16]).translate(x:-5)
    
    base += cube([30,10,5]).translate(z:16)
    base -= cube([20.2,10.2,1.2]).translate(x:15-0.1,y:-0.1,z:16)
		
		bolt = Bolt.new(3,12,additional_length:5)
	  base -= bolt.output.mirror(z:1).translate(y:5,x:25,z:21.5)
		base += bolt.show.mirror(z:1).translate(y:5,x:25,z:21.5) if with_hardware == true
		# this bolt needs a washer    
		washer = Washer.new(3.2)		
		base += washer.show.translate(y:5,x:25,z:21.0) if with_hardware == true
		
		
  end

	def belt_holder(with_hardware=false)
		base = belt_holder_base(with_hardware)

		
		bolt = Bolt.new(4,40,additional_length:5)
		base += bolt.show.rotate(x:90).translate(y:35,x:0,z:10) if with_hardware == true

		bolt = Bolt.new(4,40,additional_length:5)
		base += bolt.show.rotate(x:90).translate(y:35,x:35,z:10) if with_hardware == true
		
		belt_holder2 = belt_holder_base(with_hardware)	  

		base += belt_holder2.translate(y:23)

    base.mirror(z:1)
	end
	
end

assembly += Nema17.new.show.rotate(y:90).translate(x:95,y:460,z:-7-14)
assembly += Belt.new.show.translate(x:150,y:40,z:-14)
assembly += YBeltHolder.new().show.translate(x:135,y:230,z:3)


#assembly+= ZAxisAssembly.new.show 

#assembly += Bearing.new(:type => "624", :flange=>true).show.rotate(y:90)


file = File.open("bom.txt","w")
file.puts @@bom.output
file.close
puts "$fn=64;"+assembly.scad_output
#puts TSlot.new(size:40,configuration:2).output

