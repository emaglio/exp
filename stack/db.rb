require "sequel"

Sequel::Model.strict_param_setting = false
Sequel::Database.extension :pg_json
Sequel.extension :pg_json_ops

# Sequel::Database.extension :"uuid"
# Sequel::Model.plugin :timestamps

# MUST BE CALLED BEFORE!
# require "dotenv"
# Dotenv.load


module DB
  # @returns DB handle
  def self.connect
    environment       = ENV["RACK_ENV"]
    connection_string = ENV["DATABASE_URL"]
    raise "Missing Connection string" if connection_string.nil?

    Sequel.connect(connection_string)
  end
end
