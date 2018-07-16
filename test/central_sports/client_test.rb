require './test/test_helper'

class CentralSportsClientTest < Minitest::Test
  def test_exists
    assert ::CentralSports::Client
  end

  def test_schedule
    VCR.use_cassette('schedule', record: :new_episodes) do
      client = CentralSports::Client.new(145)
      client.schedule
    end
  end
end
