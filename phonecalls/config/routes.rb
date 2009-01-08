# Add your custom routes here.  If in config/routes.rb you would 
# add <tt>map.resources</tt>, here you would add just <tt>resources</tt>
resources :phonecalls,  :collection => { :ajax_recipients => :get }
named_route 'ajax_phonecalls', 'issues/:id/ajax_phonecalls',
  :controller => 'issues', :action => 'ajax_phonecalls', :method => :get
