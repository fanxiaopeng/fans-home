# -*- encoding : utf-8 -*-
class CnblogConvert

  def initialize(options)
    options = options.with_indifferent_access
    @user_id = options[:user_id]
    @end_point = "http://www.cnblogs.com/#{@user_id}/services/metablogapi.aspx"
    @user_name = options[:user_name]
    @password = options[:password]
  end


  def convert(&block)
    init_client
    posts = @client.recent_posts(100)
    raise 'MetaWeblog connect error' unless posts.class.to_s == 'Array'
    posts.each do |post|
      convert_one(post, &block)
    end
  end

  private

  def init_client
    @client = MetaWeblog::Client.new(@end_point, @user_id, @user_name, @password)
  end

  def convert_one(post, &block)
    title = post['title']
    created_at = post['dateCreated'].to_time
    body = post['description']
    block.call(title, created_at, body)
  end

end
