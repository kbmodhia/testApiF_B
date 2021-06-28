class KeywordMatchMailer < ApplicationMailer
    default from: 'no-replay@notifications.com'
    layout 'mailer'

    def sent_nofification
        @feed_data = params[:feed_data]        
        mail(to: 'kaustubh@facebook.com', subject: 'Found Keyword in group story')
    end
end
