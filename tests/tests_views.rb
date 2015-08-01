# encoding: utf-8
require '../start'
gem 'minitest'
require 'minitest/autorun'
require 'rack/test'
include Rack::Test::Methods
ERROR_TEXT = "Ви допустили помилку при заповненні форми. Всі поля повинні бути заповнені числами, що більші за нуль." +
    "В дробових числах ціла та дробова частини розділяються крапкою"

def app
  Start
end

describe 'test_views' do
  it 'should_be_page_with_calculator' do
    get '/'
    last_response.must_be :ok?
    last_response.body.must_include "Кредитний онлайн-калькулятор"
  end

  # this test execute post request with wrong argument: 12.
  it 'should_be_error_text_page' do
    post '/result', credit_percent: 10, credit_sum: '20000', credit_time: '12.', credit_type: 'standart'
    #print last_response.body
    last_response.body.must_include ERROR_TEXT
  end

  # this test execute post request with wrong argument: .2000
  it 'should_be_error_text_page_2' do
    post '/result', credit_percent: 10, credit_sum: '.20000', credit_time: '12', credit_type: 'standart'
    #print last_response.body
    last_response.body.must_include ERROR_TEXT
  end

  # this test execute post request with wrong argument: 20..000
  it 'should_be_error_text_page_3' do
    post '/result', credit_percent: 10, credit_sum: '20..000', credit_time: '12', credit_type: 'standart'
    #print last_response.body
    last_response.body.must_include ERROR_TEXT
  end

  # this test execute post request with wrong argument: -20..000
  it 'should_be_error_text_page_4' do
    post '/result', credit_percent: 10, credit_sum: '-20..000', credit_time: '12', credit_type: 'standart'
    #print last_response.body
    last_response.body.must_include ERROR_TEXT
  end

  # this test execute post request and check the sum of credit
  it 'should_be_page_with_results' do
    post '/result', credit_percent: 1, credit_sum: '20000', credit_time: '12', credit_type: 'standart'
    last_response.must_be :ok?
    last_response.body.must_include "20000.00"
  end
end