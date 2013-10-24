module LayoutHelper
  def title
    base_title = 'Teamscore'
    if @title.nil?
      base_title
    else
      "#{@title} | #{base_title}"
    end
  end
end
