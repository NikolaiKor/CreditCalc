# encoding: utf-8
require '../start'
gem 'minitest'
require 'minitest/autorun'
require 'rack/test'

##
# Class with tests of calculator logic
class TestLogic < Minitest::Test
  include Rack::Test::Methods

  def setup
    @input = {credit_percent: '10', credit_sum: '20000', credit_time: '24'}
    @calc_standard = StandardCredit.new(@input).count_payments
    @calc_annuity = AnnuityCredit.new(@input).count_payments
    @row_number = 15
    @standard_credit_Value = {res_credit_payment: 833.33, res_credit_percent: 62.50, res_credit: 895.83, res_remainder: 6666.67}
    @annuity_credit_Value = {res_credit_payment: 856.48, res_credit_percent: 66.42, res_credit: 922.90, res_remainder: 7113.84}
  end

  # method that check results of counting
  def check_count(calc)
    assert_equal calc.length, (@input[:credit_time].to_i + 1) #number of month + 1 row of sum values
    (calc.length - 1).times do |x|
      month = calc[x]
      assert_in_delta (month[:res_credit_payment] + month[:res_credit_percent]), month[:res_credit] #month payment = main debt + %
      #remainder on this month = remainder on previous month - main dept
      assert_in_delta calc[x-1][:res_remainder], month[:res_credit_payment] + calc[x][:res_remainder] if x > 0
    end
    last = calc.last
    assert_in_delta last[:all_credit_payment], @input[:credit_sum].to_i #sum of all main dept payments = credit size
    assert_in_delta calc[calc.length-2][:res_remainder], 0 #result remainder must be 0
  end

  #test of standard credit
  def test_standard_credit_results
    @standard_credit_Value.each { |key, value| assert_in_delta @calc_standard[@row_number][key], value, 0.03 }
    check_count @calc_standard
  end

  #test of annuity credit
  def test_annuity_credit_results
    @annuity_credit_Value.each { |key, value| assert_in_delta @calc_annuity[@row_number][key], value, 0.03 }
    check_count @calc_annuity
  end
end