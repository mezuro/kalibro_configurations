module InfinityModule
  def extract_infinity(parameter)
    if parameter == 'INF'
      Float::INFINITY
    elsif parameter == '-INF'
      -Float::INFINITY
    else
      parameter
    end
  end
end
