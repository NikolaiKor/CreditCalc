require_relative 'credit'
class AnnuityCredit < Credit
  def base_payment
    p = @percent/12
    @sum*(p + p/((1 + p)**@time - 1))
  end

  def month_payment(dept)
    result = Hash.new
    credit_percent = dept * @percent/12
    credit_payment = @base - credit_percent
    result[:res_credit_payment] = credit_payment
    result[:res_credit_percent] = credit_percent
    result[:res_credit] = @base
    result[:res_remainder] = dept - credit_payment
    result
  end

end