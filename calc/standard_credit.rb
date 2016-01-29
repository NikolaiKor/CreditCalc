require_relative 'credit'
##
# This class count standard credit month payments
class StandardCredit < Credit
  ##
  # This method calculate the main debt size
  def base_payment
    (@sum/(0.0 +@time))
  end

  ##
  # This method calculate credit, percent payment, their sum and credit remainder
  def month_payment(dept)
    result = Hash.new
    credit_percent = (dept * @percent/12)
    credit_payment = @base
    result[:res_credit_payment] = credit_payment
    result[:res_credit_percent] = credit_percent
    result[:res_credit] = (@base + credit_percent)
    result[:res_remainder] = (dept - credit_payment)
    result
  end
end