require "coordinate"

# IGC file reader
class Igc
  # Constructor
  def initialize(args = {})
    @content = []
    @filename = nil
  end

  ########################################################
  # Load a file
  ########################################################
  def load(filename)
    @filename = filename
    @content = IO.readlines(filename)
  end
  
  ########################################################
  # DIsplay file content
  ########################################################
  def display()
    puts "filename: #{@filename}"
    @content.each {|line| puts "#{line}"}
  end
  
    
  ########################################################
  # Process
  # B 121836 4721250N 00032408W A 01164 01164 12142203
  ########################################################
  def process()
    previous = nil
    @content.each do |line|
      # puts "#{line}"
      if (line =~ /^B.*/)
        match = line.match(/^B(\d{2})(\d{2})(\d{2})(\d{2})(\d{2})(\d{3})(N|S)(\d{2})(\d{3})(\d{3})(E|W)(A|V)(\d{5})(\d{5}).*/)
        # puts "#{match.inspect}"
        hour = $1.to_i
        minute = $2.to_i
        second = $3.to_i
        latitude = $4.to_f + ($5.to_f + $6.to_f / 1000) / 60
        latitude *= -1.0 if ($7 == "S")

        longitude = $8.to_f + ($9.to_f + $10.to_f / 1000) / 60
        longitude *= -1.0 if ($11 == "W")
        
        validity = $12
        palt = $13.to_i
        alt = $14.to_i
        
        point = Coordinate.new(:hour => hour, :minute => minute, :second => second, :latitude => latitude,
          :longitude => longitude, :validity => validity, :palt => palt, :alt => alt)  
        # puts "#{point.to_s}"

        if (previous != nil)
          delta = point - previous 
          puts "#{$1}:#{$2}:#{$3} #{delta.to_s(true)}"
        end
        
        previous = point
        
      end # matching B 
    end # do
  end # process

end
