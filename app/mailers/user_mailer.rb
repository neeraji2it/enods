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
  
  def contact(contact)
    @contact = contact
    mail(:to => 'Info@enods.com', :subject => contact.option)
  end
end
