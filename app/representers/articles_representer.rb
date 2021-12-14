class ArticlesRepresenter
  def initialize(articles)
    @articles = articles
  end
  def as_json
    articles.map do |article|
      {
          id: article.id,
          title: article.title,
          category: Category.find(article.category_id).name,
          content: article.title,
          image: article.image,
          reviewer: article.reviewer
      }
    end
  end
  private
  attr_reader :articles
end