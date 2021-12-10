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
        firstname: user.firstname,
        lastname: user.lastname,
        birthdate: user.birthdate,
        gender: user.gender,
        phone: user.phone,
        idendity: user.idendity,
        address: user.address,
        city: user.city
    }
  end
  private
  attr_reader :user
end