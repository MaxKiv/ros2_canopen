# MNT reset comms for node 2
cansend can0 000#8202
sleep 0.5

# MNT enter operational for node 2
cansend can0 000#0102
sleep 0.5

# Dryve state machine: Shutdown
cansend can0 602#2B40600006000000
sleep 0.5

# Wait for 0x6041 to return 0x0021

# Dryve state machine: Switch On
cansend can0 602#2B40600007000000
sleep 0.5

# Wait for 0x6041 to return 0x0023

# Dryve state machine: Enable Operation
cansend can0 602#2B4060000F000000
sleep 0.5

# Wait for 0x6041 to return 0x0027


# Set movement profile to velocity mode (3)
cansend can0 602#2F60600003000000   # 6060h sub 00 = 3 (Profile Velocity Mode)
sleep 0.5

# Set max acceleration
cansend can0 602#2383600000640000   # 6083h = 100
sleep 0.5

# Set max deceleration
cansend can0 602#2384600000640000   # 6084h = 100
sleep 0.5

# Set target speed to 25.60 rpm
cansend can0 602#23FF600000A00000   # 60FFh = 2560 rpm (little endian: 0x00000A00) = 42,7 *10^-2 (scalar defined in some object)
sleep 0.5
