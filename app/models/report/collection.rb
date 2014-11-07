module Report
  class Collection < Base

    private
    def report_sql
      sql = <<SQL
       SELECT MIN(user_visits.created_at) as range_start, COUNT(currencies.code) as visits_count
       FROM user_visits
         INNER JOIN currencies ON user_visits.country_code = currencies.country_id
       WHERE user_id = %d
       GROUP BY strftime('%s', user_visits.created_at)
SQL
      sprintf(sql, user.id, date_format)
    end

  end
end