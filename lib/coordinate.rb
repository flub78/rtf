require "delta_coordinate"

# GPS coordinate management 
class Coordinate
  
  attr_reader :time
  attr_reader :latitude
  attr_reader :longitude
  attr_reader :alt
  attr_reader :palt
  attr_reader :validity
  
  # Constructor
  def initialize(args = {})
    @time = 0
    if (args.key?(:time)) 
      @time = args[:time]
    else
      if (args.key?(:hour) && args.key?(:minute)) 
        @time = args[:hour] * 3600 + args[:minute] * 60
      end
      
      if (args.key?(:second)) 
        @time += args[:second]
      end
      
    end
   
    @latitude = args.key?(:latitude) ? args[:latitude] : 0.0
    @longitude = args.key?(:longitude) ? args[:longitude] : 0.0
      
    @alt = args.key?(:alt) ? args[:alt] : 0
    @palt = args.key?(:palt) ? args[:palt] : 0
      
    @validity = args.key?(:validity) ? args[:validity] : 'V'
  end
  
  # Image
  def to_s
    hour = @time / 3600
    minute = (@time - hour * 3600) / 60
    second = @time - hour * 3600 - minute * 60
    res = "H=#{hour}, M=#{minute}, S=#{second}, latitude=#{@latitude}, longitude=#{@longitude}" 
    res += ", validity=#{@validity}, palt=#{@palt}, alt=#{@alt}"
  end
  
  #############################################################
  # comparison
  #############################################################
  def -(other)
    delta = Delta_coordinate.new(
      :dtime => self.time - other.time,
      :dalt =>  self.alt - other.alt,
      :dpalt => self.palt - other.palt,
      :latitude => self.latitude, 
      :dlatitude => self.latitude - other.latitude,
      :dlongitude => self.longitude - other.longitude
    )
    return delta
  end
   
end
