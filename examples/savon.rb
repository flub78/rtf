require 'savon'

client = Savon.client do
  wsdl "http://www.webservicex.net/ConvertTemperature.asmx?WSDL"

  # Lower timeouts so these specs don't take forever when the service is not available.
  open_timeout 10
  read_timeout 10

  # Disable logging for cleaner spec output.
  log false
end

#response = call_and_fail_gracefully(client, :convert_temp) do

# For the corrent values to pass for :from_unit and :to_unit, I searched the WSDL for
# the "FromUnit" type which is a "TemperatureUnit" enumeration that looks like this:
#
# <s:simpleType name="TemperatureUnit">
#   <s:restriction base="s:string">
#     <s:enumeration value="degreeCelsius"/>
#     <s:enumeration value="degreeFahrenheit"/>
#     <s:enumeration value="degreeRankine"/>
#     <s:enumeration value="degreeReaumur"/>
#     <s:enumeration value="kelvin"/>
#   </s:restriction>
# </s:simpleType>
#
# Support for XS schema types needs to be improved.
# message(:temperature => 30, :from_unit => "degreeCelsius", :to_unit => "degreeFahrenheit")

response = client.call(:convert_temp, message: {temperature: 30, from_unit: "degreeCelsius", to_unit: "degreeFahrenheit"})

p response

fahrenheit = response.body[:convert_temp_response][:convert_temp_result]

p fahrenheit