class ContactMailer < ApplicationMailer
  def picture_create_mail(picture)
    @picture = picture
    #@url  = 'http://localhost:3000/pictures/#{@picture.id}'
    mail to: @picture.user.email, subject: "投稿完了メール"
  end
end
