class Node
  attr_accessor :children
  attr_accessor :name
  attr_accessor :datatype
  def initialize(fw, children, datatype)
    @name = fw.name
    @function = fw.function
    @children = children
    @datatype = datatype
  end

  def evaluate(inp)
    #puts "evaluate #{@name} {"
    inp_tmp = Array.new
    
    
    @children.each do |n|

      #puts "----- children evaluate #{n.name} #{inp} ------"

      pre_result = n.evaluate(inp)

      inp_tmp << pre_result
      
    end

    #puts "pre call #{@name} #{inp_tmp} "

    result = @function.call inp_tmp

    #puts "pos call #{result} "
    
    return result
  end

  def display (intend=0)
    puts '-'*intend + @name
    @children.each do |n|
      n.display (intend + 1)
    end
  end

end