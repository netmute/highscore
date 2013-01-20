DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/highscore.db")

class Highscore
    include DataMapper::Resource
    property :id, Serial
    property :game, String
    property :scope, String
    property :player, String
    property :score, Integer
    property :created_at, DateTime
end

DataMapper.finalize
Highscore.auto_upgrade!

before { content_type :json }

get('/') { {error:'Need a game.'}.to_json }
get '/:game' do
  Highscore.all(
    game: params[:game],
    scope: params[:scope],
    order: params[:reverse] ? :score.asc : :score.desc,
    limit: 10
  ).to_json
end

post('/') { {error:'Need a game.'}.to_json }
post '/:game' do
  Highscore.create(
    game: params[:game],
    scope: params[:scope],
    player: params[:player],
    score: params[:score]
  ).to_json
end
