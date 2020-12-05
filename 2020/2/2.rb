class Rule
  def initialize(min, max, letter)
    @min = min
    @max = max
    @letter = letter
  end

  def valid? s
    s.scan(@letter).count.between?(@min, @max)
  end
end

class RuleTwo
  def initialize(pos_a, pos_b, letter)
    @pos_a = pos_a - 1
    @pos_b = pos_b - 1
    @letter = letter
  end

  def valid? s
    s.split("").collect.with_index do | e,i |
      e if e == @letter and ( i == @pos_a or i == @pos_b )
    end.one?
  end
end

class Two
  class << Two
    def split_string klass, s
      /^(?<min>.+)-(?<max>.+) (?<letter>.): (?<p>.*$)/i =~ s
      [ klass.new(min.to_i, max.to_i, letter), p ]
    end
  end
end

@valid = 0
File.readlines("./input").each do |l|
  r, s = Two.split_string(Rule, l)
  @valid = @valid + 1 if r.valid? s
end
puts "1: #{@valid}"

@valid = 0
File.readlines("./input").each do |l|
  r, s = Two.split_string(RuleTwo, l)
  @valid = @valid + 1 if r.valid? s
end
puts "2: #{@valid}"
