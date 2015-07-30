require 'sinatra/base'
class Start < Sinatra::Base
  get '/' do
    haml :index
  end

  post '/result' do
    haml :result
  end
end
