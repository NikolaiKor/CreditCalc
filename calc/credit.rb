class Credit
  def initialize(percent, sum, type, time)
    @percent = percent/100.0
    @sum = sum
    @type = type
    @time = time
    @base = 0
  end

  def count_payments
    count_result = []
    @base = base_payment
    dept = @sum
    credit_payment = 0
    credit_percent = 0
    credit = 0
    @time.times do |i|
      row = month_payment(dept)
      credit_payment = credit_payment + row[:res_credit_payment]
      credit_percent = credit_percent + row[:res_credit_percent]
      credit = credit + row[:res_credit]
      dept = @sum - credit_payment
      count_result << (row[:month] = i)
    end
    count_result << {all_credit_payment: credit_payment, all_credit_percent: credit_percent, all_credit: credit}
  end
end