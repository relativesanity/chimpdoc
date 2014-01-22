# Chimpdoc

A super-simple publication system built around documents and files.

You know what the worst bit about blogging is? The damn web-based software. With Chimpdoc,
you use files and a text editor. Simples.

This is hardly groundbreaking software, but the idea is that you can just store some assets somewhere and chimpdoc will grab them and cache them under the hood, not caring about where they're stored. Articles in Dropbox, photos in Flickr, comments on twitter: just write an adapter and expose the resource.

# Setup

At the moment, there are two filesystem adapters: local files and dropbox.

## Local files

Setting up local files is dead easy:

````ruby
Chimpdoc.config do |c|
  c.storage(:filesystem) do |s|
    s.directory = File.join("/path/to/articles")
  end
end
blog = Chimpdoc::Blog.new
````

This will look in `/path/to/articles` for any markdown files and offer them up through `blog.feed`.

## Dropbox

You'll need a dropbox account and a dropbox developer account. Grab the developer API key and secret, and run `rake setup:dropbox` in the `chimpdoc` project directory. Follow the instructions, and you'll end up with a config block:

````ruby
Chimpdoc.config do |c|
  c.storage(:dropbox) do |s|
    s.app = {
      :key => DROPBOX_DEV_KEY,
      :secret => DROPBOX_DEV_SECRET
    }
    s.token = {
      :key => DROPBOX_CLIENT_KEY,
      :secret => DROPBOX_CLIENT_SECRET
    }
  end
end
blog = Chimpdoc::Blog.new
````

## Caching

`chimpdoc` will store articles in a cache once they've been read from the filesystem. You can configure the cache (or forget about it if your filestore is fast enough):

````ruby
Chimpdoc.config { |c| c.cache = Rails.cache }
````

# Example

I use this to allow me to update [Relative Sanity] by editing files in dropbox. There's a simple example site (not quite the same) living under the [tarzan] project. Hopefully that should help get you started.

# Contributing

This works for me, so there's not a lot of incentive for me to add things, but I know some people will find it useful. If you do, or if there's something you want to add (like tests!), please do. Same goes for [tarzan].

Happy Hacking!

[Relative Sanity]: http://www.relativesanity.com
[tarzan]: https://github.com/relativesanity/tarzan
