class Chimpdoc::Article < Struct.new(:slug, :title, :format, :content, :updated_at, :style, :published_on)

  Published = 'Published'.freeze
  Pending = 'Pending'.freeze
  Draft = 'Draft'.freeze

  def self.from_file(path_to_file)
    format, slug = parse_path_to_file(path_to_file)
    title, style, published_on, content = parse_article_source(File.read(path_to_file))
    updated_at = File.mtime(path_to_file)

    new(slug, title, format, content, updated_at, style, published_on)
  end

  def self.from_dropbox(client, file_details)
    path_to_file = file_details['path']
    format, slug = parse_path_to_file(path_to_file)
    title, style, published_on, content = parse_article_source(client.get_file(path_to_file))
    updated_at = file_details['modified']

    new(slug, title, format, content, updated_at, style, published_on)
  end

  def published?
    Published == status
  end

  def pending?
    Pending == status
  end

  def draft?
    Draft == status
  end

  def status
    if published_on
      if Date.today >= published_on
        Published
      else
        Pending
      end
    else
      Draft
    end
  end

private

  def self.parse_path_to_file(path)
    format = File.extname(path)
    slug = File.basename(path, format)
    [format, slug]
  end

  def self.parse_article_source(source)
    title, _, content = source.partition("\n\n")
    style_string, _, content = content.partition("\n\n")
    style, published_on = get_publication_details(style_string)
    [title, style, published_on, content]
  end

  def self.get_publication_details(style_string)
    style, published_on = style_string.split(/: +/)
    published_on = Date.parse(published_on) if published_on
    [style, published_on]
  end

end
