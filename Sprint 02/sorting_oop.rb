class Human
  attr_accessor :name, :phone, :age, :address 

  def initialize(name, phone, age, address)
    @name = name
    @phone = phone
    @age = age
    @address = address
  end

  def to_s
    @name + ", " + @phone + ", " + @age.to_s + ", " + @address
  end
end

class HumanCollection
  attr_accessor :humanCollection

  def initialize
    @humanCollection = []
  end
  
  def method_missing(name, *args, &block)
    method=name.to_s.split("_")
    begin
      if method[0] == "sort"
        parametr = method[method.length-1]
        eval "@humanCollection.sort!{ |x, y| x.#{parametr} <=> y.#{parametr} } "
        true
      end
    rescue
      puts "Entered parametr is not correct!"
      puts "DATA was NOT sorted!!!"
      false
    end
  end

  def to_s
    @humanCollection
  end
end

puts "Enter sorting parametr"
puts "WARNING: enter only name, phone, age or address"
sorting_parametr = gets.chomp
humanCollection = HumanCollection.new
input_file = File.new('data.csv', 'r')
while(line = input_file.gets)
  h = line.split(", ")
  human = Human.new(h[0],h[1],h[2].to_i,h[3])
  humanCollection.humanCollection.push(human)
end
if eval "humanCollection.sort_by_"+sorting_parametr
  puts humanCollection.to_s
  output_file = File.open("data.csv", 'w')
  output_file.puts humanCollection.to_s
  output_file.close
end
input_file.close
