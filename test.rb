require_relative 'calc/annuity_credit'
class Test
  def self.a
    credit = AnnuityCredit.new({credit_percent: '10', credit_sum: '20000', credit_time: '24'}).count_payments
  end
  a
end