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
    STORE_TENJIN           = 123,
    STORE_UZUMASA          = 124,
    STORE_AOTO             = 126,
    STORE_HIROSAKI         = 128,
    STORE_KAMATA           = 129,
    STORE_CHIBA            = 132,
    STORE_ALPAC_HIROSHIMA  = 134,
    STORE_HACHIOJI         = 136,
    STORE_MINAMI_URAYASU   = 137,
    STORE_HIGASHINE        = 138,
    STORE_GIFU             = 139,
    STORE_MATSUMOTO        = 141,
    STORE_UTSUNOMIYA       = 142,
    STORE_NISHIDAI         = 143,
    STORE_ISSHA            = 145,
    STORE_CHIKUSA          = 147,
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
