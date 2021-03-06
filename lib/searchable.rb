require_relative 'db_connection'

module Searchable
  def where(params)
    where_string = params.map { |attr,param| "#{attr} = ?"}.join(" AND ")

    found = DBConnection.execute(<<-SQL, *params.values)
      SELECT
        *
      FROM
        #{self.table_name}
      WHERE
        #{where_string}
    SQL
    parse_all(found)
  end
end
