module Spree
  User.class_eval do
    def valid_password?(password)
      if legacy_password?
        return false unless User.legacy_password(self.encrypted_password, password)
        self.attributes = {
          password: password,
          password_confirmation: password, 
          legacy_password: false
        }

        self.save!(validate: false)
      end
      super password
    end

    def self.legacy_password(encrypted_password, password)
      parts = encrypted_password.split(':')
      return false if parts.size != 2
      Digest::MD5.hexdigest("#{parts[1]}#{password}") == parts[0]
    end
  end
end