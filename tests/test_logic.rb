# encoding: utf-8
require '../start'
require '../calc/annuity_credit'
require '../calc/standart_credit'
gem 'minitest'
require 'minitest/autorun'
require 'rack/test'
class TestLogic < Minitest::Test
  include Rack::Test::Methods
    def setup
      @input = {credit_percent: '10', credit_sum: '20000', credit_time: '24'}
      @calc_standart = StandartCredit.new(@input).count_payments
      @calc_annuity = AnnuityCredit.new(@input).count_payments
      @row_number = 15
      @standard_credit_Value = {res_credit_payment: 833.33, res_credit_percent: 62.50, res_credit: 895.83, res_remainder: 6666.67}
      @annuity_credit_Value = {res_credit_payment: 856.49, res_credit_percent: 66.42, res_credit: 922.91}
    end

  def test_standart_credit_results
    @standard_credit_Value.each do |key, value|
      #print key.to_s + '=' + value.to_s + '|' + @calc_standart[@row_number][key].to_s + '|'
      assert_in_delta @calc_standart[@row_number][key], value, 0.03
    end
  end

  def test_annuity_credit_results
    @annuity_credit_Value.each {|key, value| assert_in_delta @calc_annuity[@row_number][key], value, 0.03}
  end
end