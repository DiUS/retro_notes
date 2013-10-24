module AccessibleAttributes
  extend ActiveSupport::Concern

  included do
    attr_accessor :accessible
  end

  private
  def mass_assignment_authorizer(role = :default)
    if accessible == :all
      self.class.protected_attributes
    else
      super + (accessible || [])
    end
  end
end
