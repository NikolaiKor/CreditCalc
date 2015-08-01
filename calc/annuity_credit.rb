require_relative 'credit'
##
# This class count annuity credit month payments
class AnnuityCredit < Credit
  ##
  # This method calculate size of monthly annuity payment
  def base_payment
    p = @percent/12
    (@sum*(p + p/((1 + p)**@time - 1)))
  end

  ##
  # This method calculate credit, percent payment, their sum and credit remainder
  def month_payment(dept)
    result = Hash.new
    credit_percent = (dept * @percent/12)
    credit_payment = (@base - credit_percent)
    result[:res_credit_payment] = credit_payment
    result[:res_credit_percent] = credit_percent
    result[:res_credit] = @base
    result[:res_remainder] = (dept - credit_payment)
    result
  end
end