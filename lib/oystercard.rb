MAX_BALANCE = 90
MINIMUM_FARE = 1
DEFAULT_BALANCE = 0

# in lib/oystercard.rb

class Oystercard
  attr_reader :balance, :entry_station, :exit_station, :log

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @entry_station = nil
    @exit_station = nil
    @log = {}
  end

  def top_up(amount)
    raise "Balance cannot exceed #{MAX_BALANCE}" if exceeded_limit?(amount)
    @balance += amount
  end

  def in_journey?
    !@entry_station.nil?
  end

  def touch_in(station = nil)
    raise 'Insufficient funds' if insufficient_funds?
    raise 'Already in journey' if in_journey?
    @entry_station = station
  end

  def touch_out(station = nil)
    raise 'Not touched in' unless in_journey?
    deduct(MINIMUM_FARE)
    @exit_station = station
    @log[@entry_station] = station unless @entry_station.nil? || @exit_station.nil?
    @entry_station = nil
  end

  private

  def exceeded_limit?(amount)
    @balance + amount > MAX_BALANCE
  end

  def insufficient_funds?
    @balance < MINIMUM_FARE
  end

  def deduct(amount)
    @balance -= amount
  end  
end
