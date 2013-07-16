class InvitationsController < ApplicationController
  before_filter :is_signin?
  def index
    @invitations = Invitation.where("user_id = #{current_user.id}").paginate :page => params[:invitation_page], :per_page => 20
    @invitation = Invitation.new
  end

  def create
    @invitation = Invitation.new(params[:invitation].merge(:user_id => current_user.id, :status => "Pending"))
    @invitations = Invitation.where("user_id = #{current_user.id}").paginate :page => params[:invitation_page], :per_page => 20
    if @invitation.save
      UserMailer.send_invitation(@invitation).deliver
      respond_to do |format|
        format.js
      end
    end
  end
end
