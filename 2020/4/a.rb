VALID_EYE_COLOURS = ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"].freeze

FIELDS = [
  {
    field: "byr",
    description: "Birth Year",
    required: true,
    validator: -> (x) { x.to_i.between?(1920, 2002) },
  },
  { 
    field: "iyr",
    description: "Issue Year",
    required: true,
    validator: -> (x) { x.to_i.between?(2010, 2020) },
  },
  { 
    field: "eyr",
    description: "Expiration Year",
    required: true,
    validator: -> (x) { x.to_i.between?(2020, 2030) },
  },
  {
    field: "hgt",
    description: "Height",
    required: true,
    validator: -> (x) { 
      [x.match(/^(?<n>\d+)(?<type>cm|in)$/)&.named_captures]&.
      map{ |x| x if not x.nil? and (
        ( x["type"] == "cm" and x["n"].to_i.between?(150, 193)) or
        ( x["type"] == "in" and x["n"].to_i.between?(59, 76) )
      )
    }.any?
  },
  },
  {
    field: "hcl",
    description: "Hair Color",
    required: true,
    validator: -> (x) { x.match?(/^#[0-9a-f]{6}$/) },
  },
  {
    field: "ecl",
    description: "Eye Color",
    required: true,
    validator: -> (x) { VALID_EYE_COLOURS.include? x },
  },
  {
    field: "pid",
    description: "Passport ID",
    required: true,
    validator: -> (x) { x.match /^\d{9}$/ },
  },
  {
    field: "cid",
    description: "Country ID",
    required: false,
    validator: -> (x) { true },
  },
]

data = File.readlines("./input").
  join("").
  split("\n\n").
  map{ |e| e.gsub("\n", " ") }

req = FIELDS.map{ |e| e[:field] if e[:required] }.compact

puts data.map{ |l| l.split(" ").map{ |e| e.split(":") }.
              map{ |f| f[0] if req.include? f[0] }.compact
}.map{|x| x if x.length == req.length }.compact.count

puts data.map{ |l| l.split(" ").map{ |e| e.split(":") }.
               map{|f| f[0] if (req.include? f[0]) and
                   (FIELDS.select{|x| x if x[:field] == f[0] }.first[:validator]).call(f[1]) }.compact
}.map{|x| x if x.length == req.length }.compact.count
