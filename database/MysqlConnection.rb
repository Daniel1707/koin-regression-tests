class MysqlConnection
  def self.connect(env)
    client = Mysql2::Client.new(:host => "localhost", :username => "root")
  end
end
