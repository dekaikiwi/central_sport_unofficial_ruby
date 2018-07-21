class CentralSports::Client
  include HTTParty
  base_uri 'https://www.central.co.jp'

  def schedule_for_club(club_id, date=Time.now.strftime('%Y%m'))
    response = self.class.get('/club/jsonp_schedule.php', schedule_options(club_id, date))
    # The Central Sports API returns () brackets at each end of the response. These cause an error
    # when encoding the JSON to Hash so we want to remove them.

    data = Oj.load(response.gsub('(', '').gsub(')', '').gsub('callback', ''))
    raise ClubDoesNotExistError.new if data['status'] == false
    CentralSports::Schedule.new(data)
  end

  def schedule_options(club_id, date)
    {
      format: :plain,
      query: {
        club_code: club_id,
        yyyymm:    date
      }
    }
  end

  class ClubDoesNotExistError < StandardError; end

end
