require './lib/central_sports'

class CentralSports::Client
  include HTTParty
  base_uri 'https://www.central.co.jp'

  STORE_CODES = [
    STORE_IDABASHI  = 282,
    STORE_TOKIWADAI = 234
  ]

  def initialize(club_id, date='201801')
    @options = {
      format: :plain,
      query: {
        club_code: club_id,
        yyyymm:    date
      }
    }
  end

  def schedule
    response = self.class.get('/club/jsonp_schedule.php', @options)
    # The Central Sports API returns () brackets at each end of the response. These cause an error
    # when encoding the JSON to Hash so we want to remove them.

    data = Oj.load(response.gsub('(', '').gsub(')', ''))
    CentralSports::Schedule.new(data)
  end

end
