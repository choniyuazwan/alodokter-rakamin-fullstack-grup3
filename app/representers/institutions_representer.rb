class InstitutionsRepresenter
  def initialize(institutions)
    @institutions = institutions
  end
  def as_json
    institutions.map do |institution|
      {
          id: institution.id,
          name: institution.name,
          location: institution.location,
          latitude: institution.latitude,
          longitude: institution.longitude
      }
    end
  end
  private
  attr_reader :institutions
end