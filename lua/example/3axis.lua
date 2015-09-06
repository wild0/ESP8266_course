    id=0
    sda=1
    scl=2

    dev_addr = 0x53

    -- initialize i2c, set pin1 as sda, set pin2 as scl
    i2c.setup(id,sda,scl,i2c.SLOW)

    -- user defined function: read from reg_addr content of dev_addr
    function read_reg(dev_addr, reg_addr)
      i2c.start(id)
      i2c.address(id, dev_addr ,i2c.TRANSMITTER)
      i2c.write(id,reg_addr)
      i2c.stop(id)
      i2c.start(id)
      i2c.address(id, dev_addr,i2c.RECEIVER)
      c=i2c.read(id,1)
      i2c.stop(id)
      return c
    end

    function write_reg(dev_addr, reg_addr, reg_value)
      i2c.start(id)
      i2c.address(id, dev_addr ,i2c.TRANSMITTER)
      i2c.write(id,reg_addr)
      --i2c.stop(id)
      --i2c.start(id)
      --i2c.address(id, dev_addr,i2c.TRANSMITTER)
      i2c.write(id,reg_value)
      i2c.stop(id)
      return c
    end
    

    function enableMeasurement()
        MEASURE = 0x08
        POWER_CTL = 0x2D

        write_reg(dev_addr, POWER_CTL, MEASURE)
        
       

    
        --bus.write_byte_data(self.address, POWER_CTL, MEASURE)

    end

    function setBanwidthRate()
        BW_RATE             = 0x2C

    BW_RATE_100HZ       = 0x0B
        

        write_reg(dev_addr, BW_RATE, BW_RATE_100HZ)

        return c
    end

    function getDeviceId()
        DEVID = 0x00
        dev = read_reg(dev_addr, DEVID)
        print(string.byte(dev))
    end

    function setRange(range_flag)
        DATA_FORMAT         = 0x31
        value = read_reg(dev_addr, DATA_FORMAT)

        value = value and (not 0x0F);
        value = value or range_flag;  
        value = value or 0x08;

        write_reg(dev_addr, DATA_FORMAT, value)
    end

    function getBanwidthRate()
        BW_RATE             = 0x2C
        rate = read_reg(dev_addr, BW_RATE)
        print(string.byte(rate))
        return rate
    end


function speed(val)
    print("speed")
    if(val>0x50 )
    then
    print("active")
        pwm.setduty(3,200) 
    else
    print("deactive")
        pwm.setduty(3,0) 
    end
    
 
end
pwm.setup(3,50,0) 
pwm.start(3) 
pwm.setduty(3,200) 
    
    -- get content of register 0xAA of device 0x77
    RANGE_2G            = 0x00

    getDeviceId()
    
    setRange(RANGE_2G)
    setBanwidthRate()
    
    enableMeasurement()
    

    tmr.alarm(0, 1000, 1, function() 
        AXES_DATA_X0           = 0x32
        AXES_DATA_X1           = 0x33
        AXES_DATA_Y0           = 0x34
        AXES_DATA_Y1           = 0x35
        AXES_DATA_Z0           = 0x36
        AXES_DATA_Z1           = 0x37
        valX0 = read_reg(dev_addr, AXES_DATA_X0)
        valX1 = read_reg(dev_addr, AXES_DATA_X1)
        valY0 = read_reg(dev_addr, AXES_DATA_Y0)
        valY1 = read_reg(dev_addr, AXES_DATA_Y1)
        valZ0 = read_reg(dev_addr, AXES_DATA_Z0)
        valZ1 = read_reg(dev_addr, AXES_DATA_Z1)

        print("X0")

       speed(number.byte(valX0))
        print(string.byte(valX0))
        print("X1")
        print(string.byte(valX1))
        --print("rate")
        --rate = getBanwidthRate()
        
    end )
    
