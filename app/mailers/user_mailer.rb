class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def alert(user)
    @user = user
    mail(:to => ['Info@enods.com'], :subject => "Subscribed")
  end
end
