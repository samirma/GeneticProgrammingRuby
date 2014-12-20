require "./object"
require "./node"
require "./fwrapper"
require "./param_node"
require "./const_node"
require "./genes"

class Genes
  attr_accessor :flist
  def initialize()

    # Numeric funcitions Proc
    add_proc = Proc.new { |a,b| a+b }

    sub_proc = Proc.new { |a,b| a-b }

    div_proc = Proc.new { |a,b| a.to_f/b.to_f }

    modulus_proc = Proc.new { |a,b| a%b }

    mult_proc = Proc.new { |a,b| a*b }

    expo_proc = Proc.new { |a,b| a**b }

    add_and_assig_proc = Proc.new { |a,b| a+=b }

    sub_and_assig_proc = Proc.new { |a,b| a-=b }

    div_and_assig_proc = Proc.new { |a,b| a/=b }

    modulus_and_assig_proc = Proc.new { |a,b| a.to_f%=b }

    mult_and_assig_proc = Proc.new { |a,b| a*=b }

    expo_and_assig_proc = Proc.new { |a,b| a**=b }

    # Operators Proc

    is_equals_proc = Proc.new do |a,b|
      final = nil
      if a == b
      final = true
      else
      final = false
      end
      final
    end

    is_not_equals_proc = Proc.new do |a,b|
      final = nil
      if a != b
      final = true
      else
      final = false
      end
      final
    end

    is_greater_proc = Proc.new do |a,b|
      final = nil
      if a > b
      final = true
      else
      final = false
      end
      final
    end

    is_less_proc = Proc.new do |a,b|
      final = nil
      if a < b
      final = true
      else
      final = false
      end
      final
    end

    is_greater_equals_proc = Proc.new do |a,b|
      final = nil
      if a >= b
      final = true
      else
      final = false
      end
      final
    end

    is_less_equals_proc = Proc.new do |a,b|
      final = nil
      if a <= b
      final = true
      else
      final = false
      end
      final
    end

    is_within_proc = Proc.new do |a,b|
      final = nil

      a_tmp = nil

      b_tmp = nil

      if a > b
        a_tmp = b

        b_tmp = a
      else
        a_tmp = a

        b_tmp = b
      end

      if a_tmp === b_tmp
      final = true
      else
      final = false
      end
      final
    end


    # IF

    if_proc = Proc.new do |a,b,c|
      final = nil
      if a
      final = b
      else
      final = c
      end
      final
    end

    @ifw = Fwrapper.new(if_proc, [:bool,:number,:number], "if")
    
    #bool

    @is_equals_w = Fwrapper.new(is_equals_proc, [:number,:number], "is_equals_proc")
    
    @is_not_equals_w = Fwrapper.new(is_not_equals_proc, [:number,:number], "is_not_equals_proc")
    
    @is_greater_w = Fwrapper.new(is_greater_proc, [:number,:number], "is_greater_proc")
    
    @is_less_w = Fwrapper.new(is_less_proc, [:number,:number], "is_less_proc")
    
    @is_greater_equals_w = Fwrapper.new(is_greater_equals_proc, [:number,:number], "is_greater_equals_proc")
    
    @is_less_equals_w = Fwrapper.new(is_less_equals_proc, [:number,:number], "is_less_equals_proc")
    
    @is_within_w = Fwrapper.new(is_within_proc, [:number,:number], "is_within_proc")

    # Funcoes numericas
    @add_w = Fwrapper.new(add_proc, [:number,:number], "add")

    @sub_w = Fwrapper.new(sub_proc, [:number,:number], "sub")

    @mul_w = Fwrapper.new(mult_proc, [:number,:number], "mul")

    @div_w = Fwrapper.new(div_proc, [:number,:number], "div")

    @modulus_w = Fwrapper.new(modulus_proc, [:number,:number], "modulus")

    @expo_w = Fwrapper.new(expo_proc, [:number,:number], "expo")
    # Funcoes numericas

    @flist= Hash.new

    @flist[:number] = [@add_w, @sub_w, @mul_w, @div_w, @ifw]

    @flist[:bool] = [@is_equals_w, @is_not_equals_w, @is_greater_w, @is_less_w, @is_greater_equals_w, @is_less_equals_w, @is_less_equals_w, @is_within_w]

  end

end
