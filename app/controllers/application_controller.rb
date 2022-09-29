class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'
  get '/' do
    { message: "Hello world" }.to_json
  end

  get '/games' do
    games = Game.all.order(:title).limit(10)
    games.to_json
  end

  get '/games/:id' do
    # Takes the given parameter of ID and searches in Games
    game = Game.find(params[:id])
    
    # Also include reviews
    # game.to_json(include: :reviews)

    # Include reviews and users
    # game.to_json(include: { reviews: { include: :user } })

    # include associated reviews with specific parameters
    game.to_json(only: [:id, :title, :genre, :price], include: {
      reviews: { only: [:comment, :score], include: {
        user: { only: [:name] }
      } }
    })
  end

end
