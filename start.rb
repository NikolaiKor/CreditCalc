# encoding: utf-8
require 'sinatra/base'
require_relative 'calc/standart_credit'
require_relative 'calc/annuity_credit'
class Start < Sinatra::Base
  set :show_exceptions, :after_handler
  get '/' do
    haml :index
  end

  post '/result' do
    type = @params[:credit_type]
    case
      when type == 'standart' then @params[:credit_result] = StandartCredit.new(@params).count_payments
      when type == 'annuity' then @params[:credit_result] = AnnuityCredit.new(@params).count_payments
    end
    haml :result
  end

  error do
    "Ви допустили помилку при заповненні форми. Всі поля повинні бути заповнені числами, що більші за нуль." +
      "В дробових числах ціла та дробова частини розділяються крапкою"
  end
end
