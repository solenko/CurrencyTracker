module Report

  class Visits < Base

    private

    def report_sql
      sql = <<SQL
       SELECT MIN(created_at) as range_start, COUNT(id) as visits_count
       FROM user_visits
       WHERE user_id = %d
       GROUP BY strftime('%s', created_at)
SQL
      sprintf(sql, user.id, date_format)
    end

  end
end
