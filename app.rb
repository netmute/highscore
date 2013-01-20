DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/scores.db")

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
    limit: params[:limit].nil? ? 10 : params[:limit].to_i
  ).to_json
end

post('/') { {error:'Need a game.'}.to_json }
post '/:game' do
  if params[:player].nil? || params[:score].nil?
    {error:'Missing params.'}.to_json
  else
    Highscore.create(
      game: params[:game],
      scope: params[:scope],
      player: params[:player],
      score: params[:score]
    ).to_json
  end
end
