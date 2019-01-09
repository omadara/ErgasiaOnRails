require 'bcrypt'

class User < ApplicationRecord
  has_secure_password
  has_many :posts, dependent: :destroy

  validates :username, uniqueness: true, presence: true, length: {minimum: 4}, if: :is_normal_acc
  validates :first_name, presence: true, length: {maximum: 50}
  validates :last_name, presence: true, length: {maximum: 50}

  def password
    @password ||= BCrypt::Password.new(password_digest) if password_digest.present?
  end

  def password=(new_password)
    @password = BCrypt::Password.create(new_password)
    self.password_digest = @password
  end

  def self.find_or_create_from_auth_hash(auth)
    where(google_uid: auth.uid).first_or_initialize.tap do |user|
      user.google_uid = auth.uid
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.password_digest = '$2a$10$ArUgkZ3/NGjnP4rdhv4eieTLtj6w00VhWs.Rgg6we6KvSodBIBzlm' #not null for bcrypt validation
      user.save!
    end
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def is_normal_acc
    google_uid.blank?
  end

  def friends
    Friend.where('user1_id = ? OR user2_id = ?', id, id) \
      .collect{|f| f.user1_id == id ? f.user2 : f.user1}
  end

  def not_friends
    User.all - friends - [self]
  end

end
