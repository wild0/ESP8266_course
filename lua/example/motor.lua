function speed(val) 
    pwm.setduty(1,val) 
   
end
pwm.setup(1,100,512) 
pwm.start(1) 
speed(100)

