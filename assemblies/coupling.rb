class Coupling
  def initialize(args={})
  
		@@bom.add(description) unless args[:no_bom] == true
	end


  def description
    "5mm to 5mm flexible aluminium coupling"
  end
  
  def output
    show
  end
  
  def show
    coupling = cylinder(d:20,h:25)
    coupling -= cylinder(d:5,h:25.2).translate(z:-0.1)
    coupling.color("Ivory")
  end

end
