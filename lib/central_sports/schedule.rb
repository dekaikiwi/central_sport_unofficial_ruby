require './lib/central_sports'

class CentralSports::Schedule
  def initialize(data)
    @data = data
  end

  def club
    ::CentralSports::Club.new(club_data)
  end

  def items
    @data['pims_schedule'].map { |i| ::CentralSports::ScheduleItem.new(schedule_item_data(i)) }
  end

  ::CentralSports::ScheduleItem::ITEM_TYPES.each do |key, value|
    define_method :"get_#{key}" do
      items.select { |i| i.send :"type_#{key}?" }
    end
  end

  private

  def club_data
    {
      name:       @data['club_name'],
      facilities: @data['pims_facility']
    }
  end

  def schedule_item_data(schedule_item)
    {
      name:             schedule_item['prognm'],
      location:         schedule_item['sisetnm'],
      day_of_week_no:   schedule_item['youbi'],
      start_time:       schedule_item['sttime'],
      end_time:         schedule_item['totime'],
      is_school:        schedule_item['school'],
      has_cost:         schedule_item['yuryokb'],
      requires_booking: schedule_item['yoyakb'],
      is_for_kids:      schedule_item['kids_flag'],
      instructor_name:  schedule_item['instnm'],
    }
  end

end
