module BillItemsHelper
  def conjugate(verb, qty)
    if qty == 1
	  t('verb.'+verb+'.3rd_person_singular')
	else
	  t('verb.'+verb+'.3rd_person_plural')
	end
  end
  
  def value_of_bill_item_by_participant(bill_item, bill_participant)
    bill_payment = BillPayment.find(:first, :conditions => { :bill_item_id => bill_item.id, :bill_participant_id => bill_participant.id } )
    if bill_payment 
      bill_payment.value
    else
      ''
    end
  end
  
  def bill_item_payment_id(item,participant)
    'bill_payment_'+item.id.to_s+'_'+participant.id.to_s
  end
end
