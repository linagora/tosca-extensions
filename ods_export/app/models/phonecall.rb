# This class represent a phone Call for a Request from a Recipient to
# an Engineer. There's also a link to the contract, because those phones
# calls can be in the 24/24 contract.
class Phonecall < ActiveRecord::Base
  acts_as_reportable

  register_action 'phonecalls_export_link'

  private
  def contract_name
    contract.name
  end
  def ingenieur_name
    ingenieur.name
  end
  def recipient_name
    recipient ? recipient.name : '-'
  end

end
