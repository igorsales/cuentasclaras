module BillItemsHelper
  def conjugate(verb, qty)
    if qty == 1
	  verb+'s'
	else
	  verb
	end
  end
end
