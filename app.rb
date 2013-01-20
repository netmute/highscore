DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/highscore.db")

class Highscore
    include DataMapper::Resource
    property :id, Serial
    property :name, String
    property :mode, String
    property :score, Float
    property :created_at, DateTime
end

DataMapper.finalize
Highscore.auto_upgrade!

get '/' do
  content_type :json
  Highscore.all(mode: params[:mode], order: :score.asc, limit: 10).to_json
end

post '/' do
  content_type :json
  Highscore.create(params).to_json
end
