
# Handle the difference between two coordinate
class Delta_coordinate
  
  #######################################################
  # Constructor
  ########################################################
  def initialize(args = {})
    @dtime = args.key?(:dtime) ? args[:dtime] : 0
    @dalt = args.key?(:dalt) ? args[:dalt] : 0
    @dpalt = args.key?(:dpalt) ? args[:dpalt] : 0
    @latitude = args.key?(:latitude) ? args[:latitude] : 0.0
    @dlatitude = args.key?(:dlatitude) ? args[:dlatitude] : 0.0
    @dlongitude = args.key?(:dlongitude) ? args[:dlongitude] : 0.0
  end
  
  ########################################################
  # Image
  ########################################################
  def to_s(full = false)
    res = "time=#{@dtime}, alt=#{@dalt}, palt=#{@dpalt}, latitude=#{@dlatitude}, longitude=#{@dlongitude}"
    if (full)
      # res += "\ndistance=#{format("%.0f", self.distance)} m, "
      res = "vi=#{format("%.0f", self.kmh)} km/h, vz=#{self.vz} m/s"
    end
  end
  
  ########################################################
  # Horizontal distance
  ########################################################
  def distance
    lat = @latitude * Math::PI / 2.0 / 90.0
    deg = 40_000.0 / 360.0 * 1000
    dist_nord = Math.cos(lat) * deg * @dlatitude
    dist_west = deg * @dlongitude
    dist = Math.sqrt(dist_nord * dist_nord + dist_west * dist_west) 
    return dist
  end

  ########################################################
  # Indicated airspedd in m/sec
  ########################################################
  def vi
    return self.distance / @dtime.to_f
  end

  ########################################################
  # Indicated airspedd in km/h
  ########################################################
  def kmh
    return self.vi * 3.6
  end
  
  ########################################################
  # Indicated airspedd in m/sec
  ########################################################
  def vz
    return @dalt.to_f / @dtime.to_f
  end
   
end
