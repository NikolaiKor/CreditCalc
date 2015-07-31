require_relative 'credit'
class StandartCredit < Credit
  def base_payment
    @sum/(0.0 +@time)
  end

  def month_payment(dept)
    result = Hash.new
    credit_percent = dept * @percent/12
    credit_payment = @base
    result[:res_credit_payment] = credit_payment
    result[:res_credit_percent] = credit_percent
    result[:res_credit] = @base + credit_percent
    result[:res_remainder] = dept - credit_payment
    result
  end
end