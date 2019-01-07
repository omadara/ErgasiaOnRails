require 'bcrypt'

class User < ApplicationRecord
  has_secure_password

  def password
    @password ||= BCrypt::Password.new(password_digest) if password_digest.present?
  end

  def password=(new_password)
    @password = BCrypt::Password.create(new_password)
    self.password_digest = @password
  end

  def self.find_or_create_from_auth_hash(auth)
    puts auth.inspect
    where(google_uid: auth.uid).first_or_initialize.tap do |user|
      user.google_uid = auth.uid
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.password_digest = '$2a$10$ArUgkZ3/NGjnP4rdhv4eieTLtj6w00VhWs.Rgg6we6KvSodBIBzlm' #not null for bcrypt validation
      user.save!
    end
  end

  def username_or_fullname
    username ? "#{username}" : "#{first_name} #{last_name}"
  end

end
