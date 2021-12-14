class ReviewerRepresenter
  def initialize(reviewer)
    @reviewer = reviewer
  end
  def as_json
    {
        id: reviewer.id,
        name: reviewer.name
    }
  end
  private
  attr_reader :reviewer
end