# -*- coding: utf-8 -*-
# Configures your navigation
SimpleNavigation::Configuration.run do |navigation|
  navigation.selected_class = 'selected'
  navigation.active_leaf_class = 'active'
  navigation.items do |primary|
    primary.dom_class = 'nav'

    primary.item :dashboard, 'Dashboard', admin_dashboard_path
    primary.item :users_index, 'Users', admin_users_path
    primary.item :site, 'Back to site', page_home_path

  end

end
