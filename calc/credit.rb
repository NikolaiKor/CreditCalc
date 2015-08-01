##
# This abstract class count credit month payments.
# Concrete class must realise method of base payment and monthly payout counting.
class Credit
  def initialize(params)
    check(params)
    @percent = params[:credit_percent].to_f/100.0
    @sum = params[:credit_sum].to_f
    @time = params[:credit_time].to_i
    @base = base_payment
  end

  ##
  # This method check input parameters.
  # They must be positive number.
  def check(params)
    [:credit_percent, :credit_sum, :credit_time].each do |key|
      value = (params[key]).to_s
      reg = value =~ /(^\d+\.)?\d+$/
      raise Exception if reg.nil? || reg > 0
    end
  end

  ##
  # This method forms table of payments
  def count_payments
    month_result = []
    dept = @sum
    credit_payment = 0
    credit_percent = 0
    credit = 0
    @time.times do
      row = month_payment(dept)
      credit_payment = credit_payment + row[:res_credit_payment]
      credit_percent = credit_percent + row[:res_credit_percent]
      credit = credit + row[:res_credit]
      dept = @sum - credit_payment
      month_result << row
    end
    month_result << {all_credit_payment: credit_payment, all_credit_percent: credit_percent, all_credit: credit}
    month_result
  end
end