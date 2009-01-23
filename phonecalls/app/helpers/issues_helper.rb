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
module IssuesHelper

  def tab_phonecall
    options = { :update => 'issue_tab',
      :before => "Element.show('spinner')",
      :success => "Element.hide('spinner')",
      :method => :get }
    issue_id = @issue ? @issue.id : @issue_id
    options[:url] = ajax_phonecalls_path(issue_id)
    desc = _('Phonecalls') + ' ' + StaticPicture::telephone
    link_to_remote_tab(desc, 'ajax_phonecalls', options)
  end

end
