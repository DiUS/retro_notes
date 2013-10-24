module Admin
  class BaseController < ApplicationController
    layout 'application_admin'

  	# Make sure the user is signed in
  	before_filter :authenticate_user!

  	# Skip access control with cancan, see note towards end of this file
  	skip_authorization_check

  	# Only allow admins in these controllers.
  	before_filter :verify_admin

  	private
  	def verify_admin
  	  redirect_to root_url unless current_user.role_greater_or_equal_to? :admin
  	end
  end
end

# NOTE: Access control
# There's really no need to use CanCan here because all the behavior is the
# same. However if you have various levels of admins which needs to access 
# different things then that's a reason to use CanCan. In that case I 
# recommend creating a separate Ability class.
# Reference: https://github.com/ryanb/cancan/wiki/Admin-Namespace

## in models/admin_ability.rb
# class AdminAbility
#   include CanCan::Ability
#   def initialize(user)
#     # define admin abilities here ....
#   end
# end
# Then use this AdminAbility for admin controllers.

## in admin/base_controller.rb
# def current_ability
#   @current_ability ||= AdminAbility.new(current_user)
# end
# Now all admin permission logic will be handled in its own AdminAbility class and everything else will be in the normal Ability class.