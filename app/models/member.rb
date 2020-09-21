class Member < ApplicationRecord
  before_create :generate_token

  devise :database_authenticatable

  validates :role,
            :email,
            :major,
            :status,
            :generation,
            :first_name,
            :start_date,
            :github_username,
            :fathers_last_name,
            :mothers_last_name,
            presence: true

  validates :github_username, uniqueness: true

  has_many :team_members
  has_many :teams, through: :team_members
  has_many :event_members
  has_many :events, through: :event_members
  has_many :arrangement_members
  has_many :arrangements, through: :arrangement_members
  has_many :reservations

  scope :sorted_by_role, -> { order('role') }
  scope :sorted_by_major, -> { order('major') }
  scope :sorted_by_status, -> { order('status') }
  scope :sorted_by_generation, -> { order('generation') }

  enum role: {
    software: 0,
    marketing: 1,
    mechanics: 2,
    electronics: 3,
  }

  enum status: {
    active: 0,
    neutral: 1,
    conditioned: 2,
    inactive: 3,
    affiliated: 4,
  }

  enum major: {
    ITC: 0,
    ISD: 1,
    IMT: 2,
    BAA: 3,
    ITI: 4,
    IID: 5,
    IM: 6,
    LIN: 7,
    LEC: 8,
    ICT: 9,
    IE: 10,
    IRS: 11,
    BGB: 12,
    INA: 13,
    ITD: 14,
    BCT: 15,
    LAD: 16,
  }

  def full_name
    "#{self.first_name} #{self.fathers_last_name} #{self.mothers_last_name}"
  end

  private

  def generate_token
    begin
      self.token = SecureRandom.uuid
    end while self.class.exists?(token: token)
  end
end
