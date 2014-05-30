#!/usr/bin/ruby1.9.3

class String
  def underscore
    word = self.dup
    word.gsub!(/::/, '/')
    word.gsub!(/([A-Z]+)([A-Z][a-z])/,'\1_\2')
    word.gsub!(/([a-z\d])([A-Z])/,'\1_\2')
    word.tr!("-", "_")
    word.downcase!
    word
  end
end

require "rubygems"
require "crystalscad"
require "require_all"

include CrystalScad

require_all "lib/**/*.rb"


@@printed_color="Bisque"
@tslot_simple = false
 




assembly = BulldozerFrameAssembly.new.show



#subassembly = YAxisAssembly.new.show
#FIXME: a way is needed to save drawings/specifications of hardware that gets modified in other classes, for example Door adds holes for hinges to the sheet, or aluminium profiles that needs drilling


def save(file,output,start_text=nil)
  file = File.open(file,"w")
  file.puts start_text unless start_text == nil
  file.puts output
  file.close
end

save("bom.txt",@@bom.output)
save("bulldozer.scad",assembly.scad_output,"$fn=64;") if assembly
save("part.scad",subassembly.scad_output,"$fn=64;") if subassembly rescue nil

parts = [YzBracket,BulldozerGearbox,BulldozerRodHolder,BulldozerIdler, BulldozerArmBearingSupport, BulldozerAcmeNutHolder,ZAcmeBearingHolderLower,ZAcmeBearingHolderUpper,XCarriage,ZLinearBearingHolder,YMotorMount,YBearingHolder,XAxisAcmeNutHolder, XAxisMountingPart,YBeltHolder,YBeltIdler,YRodHolder,ZMotorMount,ZRodHolder,XBeltIdler]
unless Dir.exists?("output")
  Dir.mkdir("output")
end
unless Dir.exists?("output/assemblies")
  Dir.mkdir("output/assemblies")
end
unless Dir.exists?("output/stl")
  Dir.mkdir("output/stl")
end
unless Dir.exists?("output/dxf")
  Dir.mkdir("output/dxf")
end

parts.each do |part|
  name = part.to_s.underscore
  save("output/#{name}.scad",part.new.output.scad_output,"$fn=64;")
  if ARGV[0] == "build"
    puts "Building #{name}..."
    system("openscad -o output/stl/#{name}.stl output/#{name}.scad")
    system("admesh output/stl/#{name}.stl -b output/#{name}.stl")
  end
end

assemblies = [MicroswitchRrd,XEndMotor,ZEndstop,YEndstop,PrinterAssembly,YzBracket,YZAxisAssembly,XAxisAssembly,YAxisAssembly,ZAxisAssembly,YMotorMount,TSlotMount,YRodHolder,BedPlate,SHF12,PSU_sp320_12,YBearingHolder]
assemblies.each do |part|
	name = part.to_s.underscore
	part.new.show.save("output/assemblies/#{name}.scad","$fn=64;")
end  
  
# dxf stuff
[YPlate].each do |part|
  name = part.to_s.underscore
  part.new.output.save("output/#{name}.scad","$fn=64;")
  if ARGV[0] == "build"
    puts "Building #{name}..."
    system("openscad -o output/dxf/#{name}.dxf output/#{name}.scad")
  end
end





