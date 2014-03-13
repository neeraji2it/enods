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
    mail(:to => 'Info@enods.com', :reply_to => contact.email, :subject => contact.option)
  end
  
  def contact_shop(contact_shop)
    @contact = contact_shop
    mail(:to => contact_shop.receiver.email, :reply_to => contact_shop.receiver.email, :subject => contact_shop.subject)
  end
  
  def invitation(user,invitation)
    @invitation = invitation
    @user = user
    mail(:to => 'ashok@dine-media.com', :subject => "Invitaiton from Enods.com")
  end
  
  def vendor_status(seller)
    @seller = seller
    mail(:to => seller.email, :subject => "Purchase Item")
  end
  
  def user_status(buyer)
    @buyer = buyer
    mail(:to => buyer.email, :subject => "Order Status")
  end
end
