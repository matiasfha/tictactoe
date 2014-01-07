Tictactoe::Application.routes.draw do
  root :to => 'tictactoe#dashboard'

  namespace :api, defaults: {format: :json} do
  	match 'move' => 'tictactoe#move', via: :post
  end
end
