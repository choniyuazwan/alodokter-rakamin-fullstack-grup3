class RegularsRepresenter
  def initialize(regulars)
    @regulars = regulars
  end
  def as_json
    regulars.map do |regular|
      {
          id: regular.id,
          name: regular.name
      }
    end
  end
  private
  attr_reader :regulars
end