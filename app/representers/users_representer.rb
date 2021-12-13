class UsersRepresenter
  def initialize(users)
    @users = users
  end
  def as_json
    users.map do |user|
      {
          id: user.id,
          email: user.email,
          firstname: user.firstname,
          lastname: user.lastname,
          birthdate: user.birthdate,
          gender: user.gender,
          phone: user.phone,
          identity: user.identity,
          address: user.address,
          city: user.city
      }
    end
  end
  private
  attr_reader :users
end