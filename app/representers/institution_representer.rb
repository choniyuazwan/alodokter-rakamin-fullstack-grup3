class InstitutionRepresenter
  def initialize(institution)
    @institution = institution
  end
  def as_json
    {
        id: institution.id,
        name: institution.name,
        location: institution.location,
        latitude: institution.latitude,
        longitude: institution.longitude
    }
  end
  private
  attr_reader :institution
end