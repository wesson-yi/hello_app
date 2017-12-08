class UserAuthenticator
  def initialize(user)
    @user = user
  end

  def authenticate(unencrpted_password)
    return false unless @user
    if BCrypt::Password.new(@user.password_digest) == unencrpted_password
      @user
    else
      false
    end
  end
end
