module Report
  class Base
    attr_reader :user

    delegate :select_values, :select_all, :to => :connection

    def initialize(user)
      @user = user
    end

    def data
      raw_data = select_all(report_sql)

      (0...raw_data.size).each do |i|
        raw_data[i]['range_start'] = Date.parse raw_data[i]['range_start']
        next if i == 0
        raw_data[i]['visits_count'] += raw_data[i - 1]['visits_count']
      end
      raw_data
    end

    protected

    def date_format
      case step
        when :month then '%Y%m'
        when :week then '%Y%W'
        when :day then '%Y%m%d'
      end

    end

    def step
      delta = max_date - min_date
      if delta > 2.month
        :month
      elsif delta > 2.weeks
        :week
      else
        :day
      end
    end

    def max_date
      load_date_range if @max_date.nil?
      @max_date
    end

    def min_date
      load_date_range if @min_date.nil?
      @min_date
    end

    def load_date_range
      min_date, max_date = select_values(sprintf("SELECT MIN(created_at), MAX(created_at) FROM user_visits WHERE user_id = %d", user.id))
      @min_date = Date.parse(min_date) rescue Date.today
      @max_date = Date.parse(max_date) rescue Date.today
    end

    def connection
      user.class.connection
    end


  end
end