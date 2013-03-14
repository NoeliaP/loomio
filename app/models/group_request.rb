class GroupRequest < ActiveRecord::Base
  attr_accessible :admin_email, :description, :expected_size, :name,
                  :cannot_contribute, :max_size, :robot_trap, :sectors_metric,
                  :other_sectors_metric, :distribution_metric

  attr_accessor :robot_trap

  validates :name, :presence => true, :length => {:maximum => 250}
  validates :description, :presence => true
  validates :admin_email, :presence => true, :email => true
  validates :expected_size, :presence => true
  validates :distribution_metric, :presence => true

  serialize :sectors_metric, Array

  belongs_to :group

  scope :awaiting_approval, where(:status => :awaiting_approval)
  scope :approved, where(:status => :approved)
  scope :accepted, where(:status => :accepted)

  before_create :mark_spam

  include AASM
  aasm column: :status do  # defaults to aasm_state
    state :awaiting_approval, initial: true
    state :approved
    state :accepted
    state :ignored
    state :marked_as_spam

    event :approve, before: :approve_request do
      transitions to: :approved, from: [:awaiting_approval, :ignored, :marked_as_spam]
    end

    event :accept_request do
      transitions to: :accepted, from: [:approved]
    end

    event :ignore do
      transitions to: :ignored, from: [:awaiting_approval, :marked_as_spam]
    end

    event :mark_as_already_approved do
      transitions to: :approved, from: [:awaiting_approval, :ignored]
    end

    event :mark_as_spam do
      transitions to: :marked_as_spam, from: [:awaiting_approval]
    end
  end

  def accept!(user)
    group.add_admin!(user)
    invitation = Invitation.where(group_request_id: id).first
    invitation.accepted = true
    invitation.save!
    accept_request!
  end


  private

  def approve_request
    @group = Group.new name: name
    @group.creator = User.loomio_helper_bot
    @group.cannot_contribute = cannot_contribute
    @group.max_size = max_size
    @group.sectors_metric = sectors_metric
    @group.other_sectors_metric = other_sectors_metric
    @group.distribution_metric = distribution_metric
    @group.save!
    @group.create_welcome_loomio
    self.group = @group
    save!
    InvitesAdminToStartGroup.invite!(self)
  end

  def mark_spam
    mark_as_spam unless robot_trap.blank?
  end
end
