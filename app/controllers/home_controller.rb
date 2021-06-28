require 'net/http'
class HomeController < ApplicationController
    
    def index
        @apiData = getGroupsData(getGroupDataUrl)      
    end

    # get usesr group data 
    def getUserGroups
        begin
            json_data = JSON.parse(request.body.read)
            if !json_data["userId"].empty?
              userId = json_data["userId"]
              userToken = json_data["userToken"]
            else
              render json: { status: "failed", "errors": [{ "field": "Invalid Json Data" }] }, status: 400
            end

            #success
            url = getGroupDataUrl(userId,userToken)
            jsonData = getGroupsData(urlInfo)
            render json: jsonData, status: 200
        rescue => e            
            render json: { status: "failed", "errors": ["message": e.message] }, status: 400           
        end
        
    end

    private
    def getGroupDataUrl(id = '',token = '')
        # please set your own user id and token hear for default url
        @userId = id.empty? ? "4697735986919539" : id
        @userToken = token.empty? ? "EAAOFiojcxXQBAOBI6KTKvj1u4yvOcOYmSNRwxIq5FtZCw0hRMylnTZB2kZCI9jvhMNfZAcGlDHyCQ4F5yclMZAkkjou5u1jjWJZBk29FBGz9YZAjHK1mwpyMjrih38ahKSYzRx0JLjJZBlQ52MAQbKrZBxHVsyzRBt2ARpsXBWfeNgOwPS0Q5cv4GKtvwKy8ZC1UbD0NuivjV0cKcX9bfC4xA50wUj7Jd6D2CYs800BDBR2nLYV6J4AZChm" : token
        return "https://graph.facebook.com/v11.0/#{@userId}/groups?access_token=#{@userToken}"
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