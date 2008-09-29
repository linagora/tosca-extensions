class Contribution < ActiveRecord::Base
  acts_as_reportable

  register_action 'contributions_export_link'

  private
  # For Ruport :
  def pname(object)
    (object ? object.name : '-')
  end

  def pname_typecontribution
    pname(typecontribution)
  end

  def pname_software
    pname(software)
  end

  def pname_etatreversement
    pname(etatreversement)
  end

  def clos_enhance
    clos ? closed_on_formatted : ''
  end

  def delay_in_words
    Time.in_words(delay)
  end

  def version_to_s
    affected_version.to_s
  end

end
