# -*- coding: utf-8 -*-
# Marketing footer
# =====================
# Used for marketing and home pages to display various social media and legal links
# For other pages, use footer_navigation.rb

SimpleNavigation::Configuration.run do |navigation|
  # Specify the class that will be applied to active navigation items. Defaults to 'selected'
  navigation.selected_class = 'selected'

  # Specify the class that will be applied to the current leaf of
  # active navigation items. Defaults to 'simple-navigation-active-leaf'
  navigation.active_leaf_class = 'active'

  primary.item :twitter, 'Twitter', 'http://twitter.com'
  primary.item :facebook, 'Facebook', 'http://facebook.com'

  end

end
