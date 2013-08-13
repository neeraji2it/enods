class InvitationsController < ApplicationController
  before_filter :is_valid_account?
  before_filter :is_signin?
  def index
    @invitations = current_user.sent_invitations.paginate :page => params[:invitation_page], :per_page => 20
    @invitation = Invitation.new
  end

  def create
    @invitation = Invitation.new(params[:invitation].merge(:status => "Pending"))
    @invitation.sender = current_user
    @invitations = current_user.sent_invitations.paginate :page => params[:invitation_page], :per_page => 20
    if @invitation.save
      @user = User.new({
          :email => @invitation.email,
          :username => @invitation.email.split('@').first,
          :password => '12345678',
          :password_confirmation => '12345678',
          :role => 'buyer'
        })
      @user.save(:validate => false)
      respond_to do |format|
        format.js
      end
    end
  end
end
