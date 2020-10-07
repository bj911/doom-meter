class UserMailer < ApplicationMailer
  def send_invite(uid, email)
    @uid = uid
    mail(to: email, subject: 'Invite User')
  end
end
