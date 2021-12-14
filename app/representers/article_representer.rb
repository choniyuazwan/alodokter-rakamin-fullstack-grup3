class ArticleRepresenter
  def initialize(article)
    @article = article
  end
  def as_json
    {
        id: article.id,
        title: article.title,
        category: Category.find(article.category_id).name,
        content: article.title,
        image: article.image,
        reviewer: article.reviewer
    }
  end
  private
  attr_reader :article
end