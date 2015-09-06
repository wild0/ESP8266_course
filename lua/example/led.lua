local M
do
  -- cache
  local gpio = gpio
  local count = 0;
  local val = gpio.read
  local writeled = function(pin)
     

    tmr.alarm(0, 1000, 1, function() 
        print("hello world") 
        count = count + 1
        if (count%2==0) 
        then
            
            gpio.mode(pin, gpio.OUTPUT) 
            gpio.write(pin, gpio.LOW)
        else 
            
            gpio.mode(pin, gpio.OUTPUT) 
            gpio.write(pin, gpio.HIGH)
        end
    end )

     
     return pin

  end
  M = {
    writeled = writeled,
  }
end
return M
