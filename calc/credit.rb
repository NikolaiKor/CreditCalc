class Credit
  def initialize(params)
    check(params)
    @percent = params[:credit_percent].to_f/100.0
    @sum = params[:credit_sum].to_f
    @time = params[:credit_time].to_i
    @base = 0
  end

  begin
    def round_up(x)
      x = x +0.01 if x%1 > 0.005
      x
    end
  end

  def check(params)
    [:credit_percent, :credit_sum, :credit_time].each do |key|
      value = (params[key]).to_s
      reg = value =~ /(^\d+\.)?\d+$/
      raise Exception if reg.nil? || reg > 0
    end
  end

  def count_payments
    month_result = []
    @base = base_payment
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
      month_result  << row
    end
    month_result << {all_credit_payment: credit_payment, all_credit_percent: credit_percent, all_credit: credit}
    month_result
  end
end