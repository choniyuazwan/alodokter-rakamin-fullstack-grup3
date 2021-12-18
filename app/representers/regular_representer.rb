class RegularRepresenter
  def initialize(regular)
    @regular = regular
  end
  def as_json
    {
        id: regular.id,
        name: regular.name
    }
  end
  private
  attr_reader :regular
end