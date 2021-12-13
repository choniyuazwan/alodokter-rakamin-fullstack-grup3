class UserRepresenter
  def initialize(user)
    @user = user
  end
  def as_json(token = false)
    token ? {
        id: user.id, 
        email: user.email,
        token: AuthenticationTokenService.call(user.id)
    } : {
        id: user.id,
        email: user.email,
        fullname: user.fullname,
        birthdate: user.birthdate,
        gender: user.gender,
        phone: user.phone,
        identity: user.identity,
        address: user.address
    }
  end
  private
  attr_reader :user
end