ActionController::Routing::Routes.draw do |map|

  map.cell "/cells/:name/:view", :controller => :cells, :action => 'show'
  map.cell "/cells",  :controller => :cells, :action => 'show'

end
