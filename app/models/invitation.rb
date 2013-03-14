class Invitation < ActiveRecord::Base
  attr_accessible :group_request

  belongs_to :inviter, :class_name => "User"
  belongs_to :group_request

  validates_uniqueness_of :token

  before_validation :generate_token, :on => :create

  delegate :group_id, :group, :admin_email, to: :group_request

  def to_param
    token
  end

  private

  def generate_token
    begin
      token = SecureRandom.urlsafe_base64
    end while Invitation.where(:token => token).exists?
    self.token = token
  end
end
