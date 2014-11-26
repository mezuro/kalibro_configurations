class RangeOverlappingValidator < ActiveModel::Validator
  def validate(record)
    record.metric_configuration.kalibro_ranges.each do |range|
      if range.id != record.id && overlaps?(range, record)
        record.errors[:beginning] << "There is already a #{record.class} within these boundaries! Please, choose another interval."
      end
    end
  end

  def overlaps?(range1, range2)
    return true if range1.beginning >= range2.beginning && range1.beginning < range2.end
    return true if range1.end > range2.beginning && range1.end <= range2.end
    return true if range1.beginning >= range2.beginning && range1.end <= range2.end
    return true if range1.beginning <= range2.beginning && range1.end >= range2.end
    return false
  end
end
