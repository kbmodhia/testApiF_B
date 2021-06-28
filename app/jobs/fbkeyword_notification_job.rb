class FbkeywordNotificationJob < ApplicationJob
  queue_as :default  
  def perform(*args)
    puts "++++++++++++"
    @group_keyword = GroupKeyword.find(args[0])
    puts @group_keyword.inspect
    puts "++++++++++++"    

    
  end
end
