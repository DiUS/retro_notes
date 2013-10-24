# -*- coding: utf-8 -*-
# Configures your navigation
SimpleNavigation::Configuration.run do |navigation|
  navigation.selected_class = 'selected'
  navigation.active_leaf_class = 'active'
  navigation.items do |primary|
    primary.dom_class = 'dropdown'

    if user_signed_in?
	    primary.item :dashboard, 'Dashboard', dashboard_path, :if => Proc.new { user_signed_in? }

	    primary.item :edit_user_registration, 'Account settings', edit_user_registration_path
	    primary.item :sign_out, 'Sign out', destroy_user_session_path, :method  => :delete

	    primary.item :page_about, 'About', page_about_path
	    primary.item :page_contact_us, 'Contact', page_contact_us_path
	    primary.item :admin_dashboard, 'Admin', admin_dashboard_path, :if => Proc.new { user_signed_in? && current_user.role_greater_or_equal_to?(:admin)}
	    

	else
		# TODO: ADD SIGN IN/UP
		primary.item :sign_up, 'Sign up', new_user_registration_path
		primary.item :sign_in, 'Sign in', new_user_session_path
	end

  end

end
