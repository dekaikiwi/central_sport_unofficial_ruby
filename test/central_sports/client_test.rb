require './test/test_helper'

class CentralSportsClientTest < Minitest::Test
  def test_exists
    assert ::CentralSports::Client
  end

  def test_api_response
    VCR.use_cassette('schedule') do
      schedule = CentralSports::Client.new(145)
    end
  end
end
