class Invitation < ActiveRecord::Base
  attr_accessible :group_request

  belongs_to :inviter, :class_name => "User"
  belongs_to :group_request

  validates_uniqueness_of :token

  before_validation :generate_token, :on => :create

  def to_param
    token
  end

  def accept!(user)
    group = Group.find(group_request.group_id)
    group.add_admin!(user)
    self.accepted = true
    save!
    group_request.accept!
  end

  private

  def generate_token
    begin
      token = SecureRandom.urlsafe_base64
    end while Invitation.where(:token => token).exists?
    self.token = token
  end
end
