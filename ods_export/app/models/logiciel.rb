class Logiciel < ActiveRecord::Base
  acts_as_reportable

  private
  def logiciels_name
    logiciel ? logiciel.name : '-'
  end

end
