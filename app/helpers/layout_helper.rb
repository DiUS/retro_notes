module LayoutHelper
  def title
    base_title = 'iRetro'
    if @title.nil?
      base_title
    else
      "#{@title} | #{base_title}"
    end
  end
end
