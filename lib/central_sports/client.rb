require './lib/central_sports'

class CentralSports::Client
  include HTTParty
  base_uri 'https://www.central.co.jp'

  STORE_CODES = [
    STORE_SANO             = 103,
    STORE_IWATSUKI         = 105,
    STORE_SHIMOKITAZAWA    = 112,
    STORE_SHOUNANHIRATSUKA = 114,
    STORE_SENDAI           = 119,
    STORE_MUSASHI_KOSUGI   = 120,
    STORE_ASAGAYA          = 122,
    STORE_IDABASHI         = 282,
    STORE_TOKIWADAI        = 234
  ]

  def initialize(club_id, date='201801')
    @options = {
      format: :plain,
      query: {
        club_code: club_id,
        yyyymm:    date
      }
    }
    schedule
  end

  def schedule
    return @schedule unless @schedule.nil?
    response = self.class.get('/club/jsonp_schedule.php', @options)
    # The Central Sports API returns () brackets at each end of the response. These cause an error
    # when encoding the JSON to Hash so we want to remove them.

    data = Oj.load(response.gsub('(', '').gsub(')', '').gsub('callback', ''))
    raise ClubDoesNotExistError.new if data['status'] == false
    @schedule = CentralSports::Schedule.new(data)
  end

  class ClubDoesNotExistError < StandardError; end

end
