puts "Enter sorting parametr"
puts "WARNING! Enter only numbers from 0 to 3:" +
                        "\n  0 if sort by name," +
                        "\n  1 if sort by phone," +
                        "\n  2 if sort by age," +
                        "\n  3 if sort by address"
sorting_parametr = gets.chomp
if (0..3).include?(sorting_parametr.to_i)
  humanCollection = []
  input_file = File.new('data.csv', 'r')
  while(line = input_file.gets)
    human = line.split(", ")
    human[2] = human[2].to_i
    humanCollection.push(human)
  end
  eval "humanCollection.sort!{ |x, y| x[#{sorting_parametr}] <=> y[#{sorting_parametr}] }"
  output_file = File.open("data.csv", 'w')
  humanCollection.each{ |human|
    human_info = human[0] + ", " + human[1] + ", " + human[2].to_s + ", " + human[3] 
    puts human_info
    output_file.puts human_info
  }
  input_file.close
  output_file.close
else
  puts "Entered parametr is not correct!"
end
