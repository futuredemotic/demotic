return {
	active = true,
	on = {
    },
    data = {
        counter = {initial=0}
    },
	execute = function(domoticz)
        -- your script logic goes here, something like this:
        local quadro = domoticz.devices['Quadro Generale Watt']
        local timer = domoticz.devices['timer']


        if (quadro.WActual > 3000 and timer.state == 'On') then

        	if (counter == 10 and quadro.WActual > 3000) then
				domoticz.notify('Superamento carico effettivo', domoticz.PRIORITY_NORMAL)
				domoticz.data.counter = 0 -- reset the counter
			else
            	domoticz.data.counter = domoticz.data.counter + 1
            	omoticz.notify('Falso superamento carico effettivo', domoticz.PRIORITY_NORMAL)


        end
    end
}