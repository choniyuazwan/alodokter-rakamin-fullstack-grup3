class ArticleRepresenter
  def initialize(article)
    @article = article
  end
  def as_json
    {
        id: article.id,
        title: article.title,
        category: Category.find(article.category_id).name,
        content: article.content,
        image: article.image,
        reviewer: Reviewer.find(article.reviewer_id).name,
        updated_at: article.updated_at,
        headline: article.headline
    }
  end
  private
  attr_reader :article
end