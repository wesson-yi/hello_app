class DonutChart
  def initialize(snapshot)
    @snapshot = snapshot
  end

  def cache_key
    @snapshot.id.to_s
  end

  def data
    # @snapshot turn it into a JSON
  end
end
