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

class Two
  class << Two
    def split_string s
      /^(?<min>.+)-(?<max>.+) (?<letter>.): (?<p>.*$)/i =~ s
      [ Rule.new(min.to_i, max.to_i, letter), p ]
    end
  end
end

@valid = 0
File.readlines("./input").each do |l|
  r, s = Two.split_string(l)
  @valid = @valid + 1 if r.valid? s
end
puts @valid
