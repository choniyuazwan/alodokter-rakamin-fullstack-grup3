class ReviewersRepresenter
  def initialize(reviewers)
    @reviewers = reviewers
  end
  def as_json
    reviewers.map do |reviewer|
      {
          id: reviewer.id,
          name: reviewer.name
      }
    end
  end
  private
  attr_reader :reviewers
end