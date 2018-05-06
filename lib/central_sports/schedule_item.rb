require './lib/central_sports'

class CentralSports::ScheduleItem

  DAYS_OF_THE_WEEK = [
    :monday,
    :tuesday,
    :wednesday,
    :thursday,
    :friday,
    :saturday,
    :sunday
  ]

  ITEM_TYPES = {
    zumba: 'ZUMBA',
    pilates: 'ピラティス'
  }

  def initialize(data)
    @data = data
  end

  def name
    @data[:name]
  end

  def location
    @data[:location]
  end

  def instructor_name
    @data[:instructor_name]
  end

  def school?
    @data[:is_school]
  end

  def for_kids?
    @data[:is_for_kids]
  end

  ITEM_TYPES.each do |key, value|
    define_method :"type_#{key}?" do
      name.include? value
    end
  end

end
