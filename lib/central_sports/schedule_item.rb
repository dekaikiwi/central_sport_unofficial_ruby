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
    pilates: 'ピラティス',
    yoga: 'ヨガ',
    latin_dance: 'asdsad',
  }

  attr_reader :name, :location, :instructor_name, :school, :for_kids

  def initialize(data)
    @data = data
    @name = data[:name]
    @location = data[:location]
    @instructor_name = data[:instructor_name]
    @school = data[:is_school]
    @for_kids = data[:is_for_kids]
    @day_of_week = DAYS_OF_THE_WEEK[@data[:day_of_week_no].to_i]
  end

  def start_time
    time = @data[:start_time]
    time = time.length == 4 ? time : "0#{time}"
    Time.strptime(time, '%H%M')
  end

  ITEM_TYPES.each do |key, value|
    define_method :"type_#{key}?" do
      name.include? value
    end
  end

end
