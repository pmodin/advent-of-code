TREE = "#"

data = File.readlines("./input")

slopes = [
  { right: 1, down: 1 },
  { right: 3, down: 1 },
  { right: 5, down: 1 },
  { right: 7, down: 1 },
  { right: 1, down: 2 },
]

slopes.each do |s|
  trees = 0
  x = y = 1

  loop do
    trees = trees + 1 if data[y-1].split("")[x-1] == TREE
    puts "We've hit #{trees} trees"

    puts "At #{x},#{y} there was #{data[y-1].split("")[x-1]}"

    puts "===="

    x = x + s.fetch(:right)
    y = y + s.fetch(:down)

    break if y > data.count

    if x > (data[y-1].strip.length) then
      x = x % data[y-1].strip.length
    end
  end
  s[:trees] = trees
end

puts "Total tree product is #{slopes.map{ |m| m[:trees] }.reduce(:*)}"
