class User
  include Mongoid::Document
  include RoleModel
  include AccessibleAttributes

  has_many :sentiment_quiz_responses

  attr_accessible :email, :password, :password_confirmation

  # IMPORTANT:
  # Define available roles. Add any new role by APPENDING on the right. Otherwise
  # the bit mask will screw up!!!!
  # Also remember to add to ROLES_ORDER
  roles :superadmin, :admin, :author, :user, :guest

  # Order the above roles from permissive to least permissive (left to right) here
  ROLES_ORDER = [:superadmin, :admin, :author, :user, :guest]
  DEFAULT_ROLE = :user # default role is user

  roles_attribute :roles_mask
  field :roles_mask, :type => Integer, :default => self.mask_for(DEFAULT_ROLE)

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ## Database authenticatable
  field :email,              :type => String, :default => ""
  validates :email,
    :presence => true,
    :uniqueness => true

  field :encrypted_password, :type => String, :default => ""

  validates_presence_of :email
  validates_presence_of :encrypted_password
  
  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  ## Confirmable
  # field :confirmation_token,   :type => String
  # field :confirmed_at,         :type => Time
  # field :confirmation_sent_at, :type => Time
  # field :unconfirmed_email,    :type => String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  # field :locked_at,       :type => Time

  ## Token authenticatable
  # field :authentication_token, :type => String

  # Check if the user has the specified role or higher
  def role_greater_or_equal_to?(role_to_check)
    self.roles.each do |role|
      return true if ROLES_ORDER.index(role_to_check) >= ROLES_ORDER.index(role)
    end
    return false
  end

  # Gets all available roles with their mask in a hash
  def self.roles_hash
    roles_hash = {}
    
    self.valid_roles.each do |role|
      roles_hash[role] = User.mask_for role
    end

    roles_hash    
  end
end
