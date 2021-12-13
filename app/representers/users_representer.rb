class UsersRepresenter
  def initialize(users)
    @users = users
  end
  def as_json
    users.map do |user|
      {
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
  end
  private
  attr_reader :users
end