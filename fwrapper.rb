class Fwrapper
  attr_accessor :function, :params, :name
  attr_accessor :name
  attr_accessor :params

  def initialize(function, params, name)
    @name = name
    @function = function
    @params = params
  end

end