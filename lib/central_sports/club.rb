class CentralSports::Club

  FACILITIES = [
    FACILITY_GYM          = 'ジム',
    FACILITY_STUDIO       = 'スタジオ',
    FACILITY_DIVING_POOL  = 'ダイビングプール',
    FACILITY_TENNIS_COURT = 'テニスコート',
    FACILITY_GOLF_RANGE   = 'ゴルフレンジ',
    FACILITY_POOL         = 'プール'
  ]


  CLUBS = YAML.load(File.open(File.join(File.dirname(__FILE__), '../data/clubs.yml')))

  def initialize(data)
    @data = data
  end

  def name
    @data[:name]
  end

  def gym?
    facility?(FACILITY_GYM)
  end

  def studio?
    facility?(FACILITY_STUDIO)
  end

  def pool?
    facility?(FACILITY_POOL)
  end

  def diving_pool?
    facility?(FACILITY_DIVING_POOL)
  end

  def tennis_court?
    facility?(FACILITY_TENNIS_COURT)
  end

  def golf_range?
    facility?(FACILITY_GOLF_RANGE)
  end

  def facility?(facility)
    @data[:facilities].any? { |f| f['nam1'] == facility}
  end
end
