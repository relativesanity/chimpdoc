class Chimpdoc::ArticleStore

  DROPBOX = :dropbox
  FILESYSTEM = :filesystem

  def get_articles
    case Chimpdoc.config.storage_type
      when FILESYSTEM then FilesystemStore.new.get_articles
      when DROPBOX then DropboxStore.new.get_articles
    end
  end

end