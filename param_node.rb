class Param_node
  attr_accessor :idx
  attr_accessor :name
  attr_accessor :datatype
  
  def initialize(idx)
    @idx = idx
    @name = "Param #{idx}"
    @datatype = :number
  end

  def evaluate(inp)
    return inp[@idx].to_f
  end

  def display (intend=0)
    puts '-'*intend + 'param' + @idx.to_s
  end

end
