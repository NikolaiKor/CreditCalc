require 'sinatra/base'
require 'tilt/haml'
require_relative 'calc/standard_credit'
require_relative 'calc/annuity_credit'
##
# This class handle requests to site pages
class Start < Sinatra::Base

  set :show_exceptions, :after_handler
  get '/' do
    haml :index
  end

  post '/result' do
    type = @params[:credit_type]
    case
      when type == 'standard' then
        @params[:credit_result] = StandardCredit.new(@params).count_payments
      when type == 'annuity' then
        @params[:credit_result] = AnnuityCredit.new(@params).count_payments
      else
        not_found
    end
    haml :result
  end

  error do
    haml :error
  end
end
