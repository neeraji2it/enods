class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def alert(user)
    @user = user
    mail(:to => ['Info@enods.com'], :subject => "Subscribed")
  end

  def send_invitation(invitation)
    @invitation = invitation
    mail(:to => invitation.email, :subject => "Invitation")
  end
end
