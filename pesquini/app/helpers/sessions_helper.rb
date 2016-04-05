=begin
File: sessions_helper.rb
Purpose: Contains login verification method.
License: GPL v3.
Pesquini Group 6
FGA - UnB Faculdade de Engenharias do Gama - University of Brasilia.
=end

module SessionsHelper

  def sign_in( user )
	
		remember_token = User.new_remember_token
		cookies.permanent[:remember_token] = remember_token
		user.update_attribute( :remember_token, User.digest( remember_token ) )
	  self.current_user = user
	
	end
	
	def current_user=( user )
    
    	@current_user = user
  	
  	end
  	
  	def current_user()
	
	    remember_token = User.digest(cookies[:remember_token])
	    @current_user ||= User.find_by( remember_token: remember_token )
  	
  	end
  	
  	def signed_in?()
    
    	!current_user.nil?()
  	
  	end

    def authorize()
    
      redirect_to '/signin', alert: "Nao autorizado !" unless signed_in?()
    
    end

    def sign_out()
    
      current_user.update_attribute( :remember_token, User.digest( User.new_remember_token ) )
      cookies.delete( :remember_token )
      self.current_user = nil
    
    end

end
