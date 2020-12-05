MOVES = ["right 3", "down 1"].freeze

Direction = Struct.new(:dir) do
  def ===(s)
    not (s =~ Regexp.new(dir)).nil?
  end
end

def move(line, move, x, y)
  right = Direction.new("right")
  down = Direction.new("down")

  x2, y2 = x.dup, y.dup
  dir, steps = [move].flatten.first.split()
  action = nil
  case dir
  when right 
    x2 = ( x + steps.to_i ) % line.length
    action = :stay
    puts "* right"
  when down
    y2 = y + steps.to_i
    action = :down
    puts "* down"
  end

  return x2, y2, action, ([move].flatten.shift)
end

require "pry"

x, y, action = 0
counter = 0
File.readlines("./sample").each do |l|
  moves ||= MOVES.dup
  loop do
    x, y, action, moves = move(l, moves, x, y)
    puts x, y, action, moves, action.to_s == 'down', "==="

    break if action == :down
    break if moves.empty?
    if counter == 3 then
      counter = 0
      break
    else
      counter = counter + 1
    end
  end
end
