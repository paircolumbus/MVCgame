class Model

  attr_reader :byeCounts

  def initialize
    @byeCounts = 0
  end

  def incrementByeCount
    @byeCounts = @byeCounts + 1
  end

end
