CSCI3308FinalProject::Application.routes.draw do
  root :to => 'account#login'
  match '/login',       to: 'account#login',       via: 'get'
  match '/login_check', to: 'account#login_check', via: 'post'

  match '/new',         to: 'account#new',         via: 'get'
  match '/create',      to: 'account#create',      via: 'post'

  match '/friends',     to: 'account#friends',     via: 'get'
  match '/preferences', to: 'account#preferences', via: 'get'
  match '/update',      to: 'account#update',      via: 'post'

  match '/logout',      to: 'account#logout',      via: 'get'

  match '/send_request',to: 'friend#send_request',via: 'get'
  match '/add',         to: 'friend#add',         via: 'get'
  match '/deny',        to: 'friend#deny',        via: 'get'
  match '/defriend',    to: 'friend#defriend',    via: 'get'

  match '/newsfeed',    to: 'viewing#newsfeed',    via: 'get'
  match '/profile',     to: 'viewing#profile',     via: 'get'
  match '/post',        to: 'viewing#post',        via: 'post'
  match '/clear_wall',  to: 'account#clear_wall',  via: 'get'
end
