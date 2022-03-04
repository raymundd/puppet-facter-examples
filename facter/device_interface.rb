# Facter for testing
#
Facter.add(:network_device) do
  setcode do
    confine kernel: 'Linux'
    intf = {}
    Facter.value(:networking)['interfaces'].each do |interface, value|
      if not interface.include? "lo"	    
	      driver = `/usr/sbin/ethtool -i #{interface} | grep 'driver'`.split(':')[1].strip
	if intf[driver]
          intf[driver] = interface + ',' + (intf[driver] || "")
	else
	  intf[driver] = interface
	end
      end
    end
    intf
  end
end
