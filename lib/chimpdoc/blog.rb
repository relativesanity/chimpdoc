class Chimpdoc::Blog

  CACHE_KEY = 'articles'

  def reload_articles
    if cache
      cache.write(CACHE_KEY, load_articles)
    else
      load_articles
    end
  end

  def cover_article
    feed.first
  end

  def next_article_date
    next_article.try(:published_on)
  end

  def next_article
    preview_feed.first
  end

  def feed
    published_articles.sort_by(&:published_on).reverse
  end

  def preview_feed
    pending_articles.sort_by(&:published_on)
  end

  def fetch_article(slug)
    published_articles.find { |a| slug == a.slug }
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
      cache.fetch(CACHE_KEY) { load_articles }
    else
      load_articles
    end
  end

  def load_articles
    article_store.get_articles
  end

  def cache
    Chimpdoc.config.cache
  end

  def article_store
    @article_store ||= Chimpdoc::ArticleStore.new
  end

end