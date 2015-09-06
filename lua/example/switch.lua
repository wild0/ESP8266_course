local M
do
  -- cache
  local gpio = gpio
  local count = 0;
  local val = gpio.read
  local open = function(pin)
     

    tmr.alarm(0, 1000, 1, function() 
        print("hello switch") 
        count = count + 1
        
            gpio.mode(pin, gpio.OUTPUT) 
            gpio.write(pin, gpio.LOW)
        
    end )

     
     return pin

  end
  M = {
    open = open,
  }
end
return M