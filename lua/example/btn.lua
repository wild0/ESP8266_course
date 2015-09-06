local M
do
  -- cache
  local gpio = gpio
  local val = gpio.read
  local enableButton = function(btnPin, ledPin)
    gpio.mode(ledPin, gpio.OUTPUT) 
    gpio.mode(btnPin, gpio.INPUT) 
    
    tmr.alarm(0, 1000, 100, function() 
        print("hello world") 
        if (val(btnPin)==gpio.HIGH) 
        then
            
            gpio.write(ledPin, gpio.HIGH)
        else 
            
            gpio.write(ledPin, gpio.LOW)
        end
    end )
    return ledPin
  end
  M = {
    enableButton = enableButton,
  }
end
return M
