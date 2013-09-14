#!/usr/bin/env ruby

require 'rmodbus'
require 'timeout'

# PORT = '/dev/ttyACM0'
PORT = '/dev/tty.usbserial-A9WF3X91'
BAUD = 19200
DEV_NUM = 16

module Busykoala
  module Daemon
    class TimeoutException < Exception; end

    class Utils
      class << self
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
      end
    end

    class Fetcher
      def self.run
        begin
          client = ModBus::RTUClient.new(PORT, BAUD, :parity => SerialPort::EVEN)
          while true
            fetcher = self.new(client)
            fetcher.detect
            fetcher.fetch
            Device.update_all(fetcher.devices)
            break
          end
        ensure
          client.close
        end
      end

      attr_reader :devices
      INPUT_REGISTERS_OFFSET = 20
      TIMEOUT = 0.1

      def initialize(client)
        # @config = Busykoala::Config
        @client = client
        @devices = []
      end

      def detect
        DEV_NUM.times do |i|
          index = i+1
          device = nil

          begin
            ::Timeout.timeout(TIMEOUT, Busykoala::Daemon::TimeoutException) do
              @client.with_slave(index) do |slave|
                device = [ index ] + slave.read_input_registers(0, 20)
              end
            end
          rescue Busykoala::Daemon::TimeoutException => err
          end

          @devices << device if device
        end

        @devices.map! { |d| parse_device_info(d) }
      end

      def fetch
        @devices.each do |device|
          @client.with_slave(device[:address]) do |slave|
            device[:num_discrete_inputs].times do |i|
              device[:info_discrete_inputs] << slave.read_discrete_inputs(i, 1).first
            end

            device[:num_coil].times do |i|
              device[:info_coil] << slave.read_coils(i, 1).first
            end

            device[:num_input_register].times do |i|
              device[:info_input_register] << slave.read_input_registers(INPUT_REGISTERS_OFFSET + i, 1).first
            end

            device[:num_holdings].times do |i|
              device[:info_holdings] << slave.read_holding_registers(i, 1).first
            end
          end
        end
      end

      private

      def parse_device_info(raw)
        {
          :address              => raw[0],
          :uuid                 => Busykoala::Daemon::Utils.holdings2string(raw[1..16]),

          :num_discrete_inputs  => raw[17], # r      0/1
          :num_coil             => raw[18], # rw     0/1
          :num_input_register   => raw[19], # r      string
          :num_holdings         => raw[20], # rw

          :info_discrete_inputs => [],
          :info_coil            => [],
          :info_input_register  => [],
          :info_holdings        => []
        }
      end
    end
  end
end

Busykoala::Daemon::Fetcher.run
