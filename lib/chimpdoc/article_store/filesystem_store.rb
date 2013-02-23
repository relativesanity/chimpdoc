class Chimpdoc::ArticleStore::FilesystemStore

  def get_articles
    Dir.entries(config.directory).collect do |entry|
      File.join(config.directory, entry)
    end.select do |filename|
      File.file?(filename)
    end.collect do |file|
      Chimpdoc::Article.from_file(file)
    end
  end

private

  def config
    Chimpdoc.config.storage
  end

end