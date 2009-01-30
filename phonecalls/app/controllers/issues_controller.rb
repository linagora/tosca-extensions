#
# Copyright (c) 2006-2009 Linagora
#
# This file is part of Tosca
#
# Tosca is free software, you can redistribute it and/or modify
# it under the terms of the GNU General Public License as
# published by the Free Software Foundation; either version 2 of
# the License, or (at your option) any later version.
#
# Tosca is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
class IssuesController < ApplicationController
  helper :phonecalls

  def ajax_phonecalls
    return render(:nothing => true) unless request.xhr?
    @issue = Issue.find(params[:id])
    conditions = [ 'phonecalls.issue_id = ? ', @issue.id ]
    options = { :conditions => conditions, :order => 'phonecalls.start',
      :include => [:engineer, :recipient,:contract,:issue] }
    @phonecalls = Phonecall.all(options)
    render :partial => 'issues/tabs/tab_phonecalls', :layout => false
  end

end
