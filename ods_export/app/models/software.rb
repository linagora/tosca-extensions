class Software < ActiveRecord::Base
  acts_as_reportable

  private
  def softwares_name
    software ? software.name : '-'
  end

end
