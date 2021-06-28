class FbkeywordNotificationJob < ApplicationJob
  queue_as :default  
  def perform(*args)
    puts "++++++++++++"
    @group_keyword = GroupKeyword.find(args[0])
    puts @group_keyword.inspect
    puts "++++++++++++"    
    url = getGroupFeedDataUrl(@group_keyword.groupid)
    @apiData = getGroupsData(url)

    if !@apiData['data'].nil? && (@apiData['data'].to_s.include? @group_keyword.keyword)
      # send mail notification
      # notification code will be hear
      @apiData['data'].each do |feedData|
        if feedData.name.include? @group_keyword.keyword
          KeywordMatchMailer.with(feed_data: feedData).sent_nofification.deliver_now
        end
      end
    end

  end

  private
    def getGroupFeedDataUrl(id = '')
        # please set your own user id and token hear for default url
        @groupId = id.empty? ? "4697735986919539" : id
        @userToken = token.empty? ? "EAAOFiojcxXQBAEzRD1VBLZCSnuS8Jzs4Nclt1WxMnZCZAT48BtWebZAxcuzmllHZBKhKHDpe9IVBHKFVAXMnTE2o0EhoNujufukxomJ0ZCNHDzC6r1B1Ir7xn7GmpflV4oI3faRhQQXm1VfXDS7h4JtgFVyY5vE0awgfqYMgzw2cIZCxZCt8Xp6XKZAKQLJFBa8ZBap6iTzjlTjztvBnFzEspXJGPpRyYOKSrvEbXIOW76McvLGBF3piIf" : token
        return "https://graph.facebook.com/v11.0/#{@groupId}/feed?limit=5&access_token=#{@userToken}"
    end

    def getGroupsData(urlInfo = '')
        # check if url info is nil
        url = URI(urlInfo) 
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        request = Net::HTTP::Get.new(url)       
        request["content-type"] = 'application/json'
        response = http.request(request)        
        apiData = JSON.parse(response.read_body)
        return apiData
    end
end
