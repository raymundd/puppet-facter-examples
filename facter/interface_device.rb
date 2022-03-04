# Facter for testing
#
Facter.add(:my_interfaces) do
  setcode do
    confine kernel: 'Linux'
    intf = {}
    driver = ''
    Facter.value(:networking)['interfaces'].each do |interface, value| 
      driver = `/usr/sbin/ethtool -i #{interface} | grep 'driver'`
      if driver.include? 'e1000'
        intf[interface] = driver
      end
    end
    intf
  end
end
