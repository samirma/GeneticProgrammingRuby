require "./object"
require "./node"
require "./fwrapper"
require "./param_node"
require "./const_node"
require "./genes"


genes = Genes.new()

@flist = genes.flist

@index = 0

def makerandomtree (pc, datatype = 'random', maxdepth=4, fpr=0.7, ppr=0.6, first = true)
  ran = Random.rand
  if (ran<fpr and  maxdepth > 0) or first
    f = nil
    
    if first
      datatype = :number
    end

    datatype_tmp = nil
    
    values = @flist[datatype]
    
    if values
      
      f = values.sample(1).last
      
    else
      
      datatype_tmp = @flist.keys.sample(1).last unless values
      
      f = @flist[datatype_tmp].sample(1).last
      
    end
    
    children = Array.new
    
    f.params.each do |type|
      #puts "Criando node tipo: #{type} para #{f.name}"
      node_tmp = makerandomtree pc, type , maxdepth - 1 , fpr, ppr, false
      children << node_tmp
    end
    return Node.new(f, children, datatype)

  elsif Random.rand<ppr
    param_num = Random.rand(0 .. (pc - 1))
    return Param_node.new ( param_num )
  else
    rand_num = Random.rand(1 .. 10)
    return Const_node.new ( rand_num )
  end

end

def hiddenfunction (x,y)
  x**2+2*y+3*x+5
end


###############################################

def crossover( t1, t2, probswap=0.7, first = true)
  if Random.rand<probswap and !first
    
    return t2.deep_clone
    
  else
    
    result = t1.deep_clone
    
    if t1.respond_to?(:children) and t2.respond_to?(:children)
      children = []
      t1.children.each do |c|
        
        tmp = t2.children.sample(1).last
        
        new_node = c
        
        if tmp.datatype == c.datatype 
          new_node = crossover c, tmp, probswap, first = false 
        end
        
        children << new_node
      end
      result.children = children
      
    end
    
    return result
    
  end
  
end

def mutate(t,pc,probchange=0.1)
  if Random.rand<probchange
    new_node = makerandomtree pc, datatype = t.datatype
    return new_node
  else
    result = t.deep_clone
    if t.respond_to?(:children)
      children = []
      t.children.each do|c|
        new_node = mutate c, pc, probchange
        children << new_node
      end
      result.children = children
    end

    return result
  end
end

##############################################

def scorefunction(tree,s)
  dif=0
  s.each do |data|
    #puts "#{data[0]} #{data[1]} = #{data[2]} "
    v=tree.evaluate([data[0], data[1]])
    if v.infinite? or v.nan?
      return nil
    end
    dif+=(v-data[2]).abs
  end
  #puts dif.to_f
  return dif.to_f
end

def buildhiddenset
  rows = []
  for n in 1 .. 200
    rand_num1 = Random.rand(1 .. 40)
    rand_num2 = Random.rand(1 .. 60)
    rows << [rand_num1, rand_num2, hiddenfunction(rand_num1, rand_num2)]
  end
  return rows
end

@hiddenset = buildhiddenset

def rankfunction(population)
  scores = []
  
  population.each do |ind|
    score = scorefunction(ind, @hiddenset)
    next if score == nil
    scores << [score, ind]
  end
  
  def score_sort(x, y)
    #puts "#{x[0]} #{y[0]}"
    return x[0] <=> y[0]
  end
  
  scores.sort! { |x, y| score_sort(x, y)}
  
  return scores
end

def rank
  puts "teste"
end


def evolve(pc, popsize, maxgen=500, mutationrate=0.2, breedingrate=0.1 ,pexp=0.7,pnew=0.1)
  
  population = []
  
  for n in 1 .. popsize
    pop = makerandomtree pc, maxdepth = Random.rand(2 .. 15)
    population << pop
  end
  
  scores = nil
  
  for n in 1 .. maxgen
    scores = rankfunction population
    
    if scores[0][0]==0.0
      break
    end
    
    best1 = scores[0][1]
    best2 = scores[1][1]
    
    newpop = []
    
    newpop << best1
    newpop << best2
    
    puts "#{n} / #{maxgen}"
    puts "best1: #{scores[0][0]}"
    
    
    puts "============================================="
    
    #Gerando nova populacao
    while newpop.size < popsize
      
      if Random.rand > pnew
        
        max = popsize*(1-pexp)
        
        rand_ind1 = Random.rand(0 .. max)
        rand_ind2 = Random.rand(0 .. max)
        
        ind1 = scores[rand_ind1][1]
        ind2 = scores[rand_ind2][1]
        
        cross = crossover(ind1, ind2, probswap=breedingrate)
        
        mutante = mutate cross, pc, probchange=mutationrate
                
        newpop << cross
        
      else
        new_ind = makerandomtree pc, maxdepth=10
        newpop << new_ind
      end
      
    end
    
    population = newpop
      
  end
  
  scores[0][1].display()    
  return scores[0][1]
  
end


result = evolve 2, 800, 200


puts "The result should be: 141 #{result.evaluate([8, 24])}"

