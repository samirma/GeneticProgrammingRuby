class Const_node
  attr_accessor :name
  attr_accessor :datatype
  
  def initialize(v)
    @v = v
    @name = "Const(#{v})"
    @datatype = :number
  end

  def evaluate(inp)
    return @v.to_f
  end

  def display (intend=0)
    puts '-'*intend + @v.to_s
  end

end
