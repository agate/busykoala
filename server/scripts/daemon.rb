#!/usr/bin/env ruby

# PORT = '/dev/ttyACM0'
PORT = '/dev/tty.usbmodemfd1221'

def bytes2holdings(bytes)
  bytes.each_slice(2).map { |arr| arr[0] * 256 + arr[1].to_i }
end

def holdings2bytes(holdings)
  holdings.map do |holding|
    low = holding % 256
    high = (holding - low) / 256
    [ high, low ]
  end.flatten
end

def string2holdings(str)
  bytes2holdings(str.bytes)
end

def holdings2string(holdings)
  holdings2bytes(holdings).pack("c*")
end

cl = ModBus::RTUClient.new(PORT, 19200, :parity => SerialPort::EVEN)
cl.with_slave(3) do |slave|
  puts slave.read_discrete_inputs(0, 1)

  slave.write_single_coil(0, 1)
  puts slave.read_discrete_inputs(0, 1)
  sleep(0.2)

  slave.write_coils(0, [0])
  puts slave.read_coils(0, 1)

  adc = slave.read_input_registers(0, 1).first
  printf "%4d\t%.2f%%\n", adc, adc / 10.23

  slave.write_multiple_registers(10, string2holdings("hello"))
  puts holdings2string(slave.read_holding_registers(10, 3))

  slave.write_multiple_registers(10, string2holdings("world"))
  puts holdings2string(slave.read_holding_registers(10, 3))
end
cl.close

# cl = ModBus::RTUClient.new(PORT, 19200, :parity => SerialPort::EVEN)
# cl.with_slave(3) do |slave|
  # while true do
    # puts slave.read_discrete_inputs(0, 1)
    # sleep 0.5
  # end
# end
# cl.close
