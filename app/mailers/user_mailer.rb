class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def alert(user,product)
    @user = user
    @product = product
    mail(:to => user.email, :body => product.description, :subject => product.title)
  end
end
