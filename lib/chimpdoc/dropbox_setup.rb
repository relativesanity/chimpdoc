require "dropbox_sdk"

class DropboxSetup

  attr_accessor :app_key, :app_secret, :access_token_key, :access_token_secret

  def initialize
    @app_key = nil
    @app_secret = nil
    @access_token_key = nil
    @access_token_secret = nil
  end

  def self.perform
    DropboxSetup.new.tap { |setup| yield setup }
  end

  def prompt_for_app_credentials
    puts "Enter App Key:"
    @app_key = STDIN.gets.chomp

    puts "Enter App Secret:"
    @app_secret = STDIN.gets.chomp
  end

  def authorise
    DropboxSession.new(app_key, app_secret).tap do |session|
      session.get_request_token
      
      prompt_for_authorisation(session)
      
      session.get_access_token
      
      @access_token_key = session.access_token.key
      @access_token_secret = session.access_token.secret
    end
  end

  def config
    config = {
      app_key: app_key,
      app_secret: app_secret,
      access_token_key: access_token_key,
      access_token_secret: access_token_secret
    }
    puts config
  end

  private

  def prompt_for_authorisation(session)
    puts "Please visit #{session.get_authorize_url} and hit 'Allow', then hit Enter here:"
    STDIN.gets.chomp
  end
end