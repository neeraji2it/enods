class InvitationsController < ApplicationController
  before_filter :is_signin?
  before_filter :is_valid_account?
  def index
    @invitations = current_user.sent_invitations.paginate :page => params[:invitation_page], :per_page => 20
    @invitation = Invitation.new
  end

  def create
    @invitation = Invitation.new(params[:invitation].merge(:status => "Pending"))
    @invitation.sender = current_user
    @invitations = current_user.sent_invitations.paginate :page => params[:invitation_page], :per_page => 20
    user = Invitation.find_by_sender_id_and_email(current_user.id, params[:invitation][:email])
    if !user.present?
      if @invitation.save
        UserMailer.invitation(current_user, @invitation).deliver
      end
      respond_to do |format|
        format.js
      end
    else
      render :update do |page|
        page.alert("Email Is Already Taken!")
      end
    end
  end
end
