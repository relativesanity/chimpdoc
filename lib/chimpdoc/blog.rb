class Chimpdoc::Blog

  CACHE_KEY = 'articles'

  # Public: Retrieves the most recently published article in the blog
  #
  # Returns an Article
  def cover_article
    feed.first
  end

  # Public: Returns the publication date of the next article
  #
  # Intended to be used to provide information to blog readers on when the next article is
  # predicted to hit
  #
  # Returns a Date
  def next_article_date
    next_article.try(:published_on)
  end

  # Public: Retrieves the soonest future-published article
  #
  # Exists primarily for use by the next_article_date method. Should probably be private
  #
  # Returns an Article
  def next_article
    preview_feed.first
  end

  # Public: Retrieves all currently-published articles, ordered by latest-first
  #
  # Returns an Enumerable collection of Articles
  def feed
    published_articles.sort_by(&:published_on).reverse
  end

  # Public: Retrieves all upcoming-published articles, ordered by soonest-first
  #
  # Returns an Enumerable collection of Articles
  def preview_feed
    pending_articles.sort_by(&:published_on)
  end

  # Public: Retrieves a specific published article based on its slug
  #
  # Returns an Article
  def fetch_article(slug)
    published_articles.find { |a| slug == a.slug }
  end

  # Public: Refresh the article cache from the store, if we have a cache specified
  #
  # This is designed to be called from a rake task or other automated system
  def refresh_articles
    if cache
      articles = get_articles
      cache.write(CACHE_KEY, articles)
    end
  end

  private

  def published_articles
    return [] unless articles
    articles.select(&:published?)
  end

  def pending_articles
    return [] unless articles
    articles.select(&:pending?)
  end

  def articles
    if cache
      cache.fetch(CACHE_KEY) { get_articles }
    else
      get_articles
    end
  end

  def get_articles
    article_store.get_articles
  end

  def cache
    Chimpdoc.config.cache
  end

  def article_store
    @article_store ||= Chimpdoc::ArticleStore.new
  end

end