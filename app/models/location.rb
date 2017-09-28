class Location < ActiveRecord::Base

  def get_around_my(objet_name, distance)
    @connection = ActiveRecord::Base.connection

    result = @connection.exec_query('select tablename from system.tables')
      result.each do |row|
              
      end
  end

end
