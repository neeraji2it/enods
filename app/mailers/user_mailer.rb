class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def alert(user)
    @user = user
    mail(:to => ['Info@enods.com'], :subject => "Subscribed")
  end
  
  def project_alert(email,product)
    @email = email
    @product = product
    mail(:to => email.email, :subject => product.title)
  end
end
