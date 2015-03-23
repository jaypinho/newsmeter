class SessionsController < ApplicationController
	# As per comment here: http://stackoverflow.com/questions/15351985/session-not-persisting-across-redirect-with-omniauth-and-rails-4
	skip_before_filter :verify_authenticity_token

  def new
  end

  def create
  	auth_hash = request.env['omniauth.auth']

  	if session[:user_id]
  		# Means our user is signed in. Add the authorization to the user
  		User.find(session[:user_id]).add_provider(auth_hash)

  		render :text => "You can now login using #{auth_hash["provider"].capitalize} too!"
  	else
  		#Log him in or sign him up
  		auth = Authorization.find_or_create(auth_hash)

  		# Create the session
  		session[:user_id] = auth.user.id
  		puts ("HERE'S THE USER ID: " + auth.user.id.to_s)
  		puts ("HERE'S THE SESSION ID: " + session[:user_id].to_s)

  		render :text => "Welcome #{auth.user.name}!"
  	end
  end

  def failure
  	render :text => "Sorry, but you didn't allow access to our app!"
  end

  def destroy
  	session[:user_id] = nil
  	render :text => "You've logged out!"
  end

end