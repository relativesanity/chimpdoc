class Chimpdoc::ArticleStore::DropboxStore

  ARTICLE_DIR = 'articles'.freeze
  ARTICLE_EXT = '.md'.freeze

  def get_articles
    dropbox_client.search(ARTICLE_DIR, ARTICLE_EXT).collect do |r|
      Chimpdoc::Article.from_dropbox(dropbox_client, r)
    end
  end

  def dropbox_client
    @dropbox_client ||= get_client
  end

private

  def get_client
    session = DropboxSession.new(config.app[:key], config.app[:secret])
    session.set_access_token(config.token[:key], config.token[:secret])
    DropboxClient.new(session, :app_folder)
  end

  def config
    Chimpdoc.config.storage
  end

end