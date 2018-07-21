require './test/test_helper'

class CentralSportsClientTest < Minitest::Test
  def test_exists
    assert ::CentralSports::Client
  end

  def test_schedule_for_club
    VCR.use_cassette('schedule', record: :new_episodes) do
      client = CentralSports::Client.new
      client.schedule_for_club(145)
    end
  end

  def test_schedule_raise_error_when_store_doesnt_exist
    VCR.use_cassette('schedule', record: :new_episodes) do
      assert_raises ::CentralSports::Client::ClubDoesNotExistError do
        client = CentralSports::Client.new
        client.schedule_for_club(99999)
      end
    end
  end
end
