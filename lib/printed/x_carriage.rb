class XCarriage < CrystalScad::Assembly
  def initialize(args={})

  end

  def part(show)
    res = import("import/x-carriage.stl")
  end

end
