
# Handle the difference between two coordinate
class Delta_coordinate
  
  attr_reader :nb
  
  @@nb = 0

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
      
    @@nb += 1
  end
  
  ########################################################
  # Image
  ########################################################
  def to_s(full = false)
    res = "time=#{@dtime}, alt=#{@dalt}, palt=#{@dpalt}, latitude=#{@dlatitude}, longitude=#{@dlongitude}"
    if (full)
      # res += "\ndistance=#{format("%.0f", self.distance)} m, "
      res = "vs=#{format("%.0f", self.kmh)} km/h, vz=#{self.vz} m/s"
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
  # Track
  ########################################################
  def trk
    lat = @latitude * Math::PI / 2.0 / 90.0
    deg = 40_000.0 / 360.0 * 1000
    dist_nord = Math.cos(lat) * deg * @dlatitude
    dist_west = deg * @dlongitude
    
    # puts "dist_nord=#{dist_nord}, dist_west=#{dist_west}"
    if (dist_west.abs < 0.000_000_000_1)
      if (dist_nord > 0.0)
        trk = 0.0
      else
        trk = 180.0
      end
    else
      trk = Math.atan2(dist_nord, dist_west) / Math::PI * 180.0
      trk = (trk + 90.0).modulo(360.0)
    end
    return trk
  end

  ########################################################
  # Indicated airspedd in m/sec
  ########################################################
  def vs
    return self.distance / @dtime.to_f
  end

  ########################################################
  # Indicated airspedd in km/h
  ########################################################
  def kmh
    return self.vs * 3.6
  end
  
  ########################################################
  # Indicated airspedd in m/sec
  ########################################################
  def vz
    return @dalt.to_f / @dtime.to_f
  end
   
end
