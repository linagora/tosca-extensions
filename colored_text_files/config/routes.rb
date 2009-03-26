# named_route 'uv_attachment', "/attachments/:id/uv/",
#  :controller => 'attachments', :action => 'uv', :method => :get
resources :attachments, :member => { :uv => :get }
