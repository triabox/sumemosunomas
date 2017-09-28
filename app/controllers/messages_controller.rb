class MessagesController < ApplicationController
  before_filter :require_login
  before_action :set_all_menssages, only: [:conversation]
  before_action :set_new_message, only: [:conversation, :new_message_recurso]

  def index
    @messages =  Message.where(["subject_user_id = :id", { id: current_user.id }])
                        .order("sender_user_id ASC, created_at DESC").select('DISTINCT ON ("sender_user_id") *')
  #@messages=  Message.where(["subject_user_id = :id OR sender_user_id = :id", { id: current_user.id }, { id2: current_user.id }])
  #                  .order("sender_user_id ASC, subject_user_id ASC, created_at DESC").group("sender_user_id").group("subject_user_id").group("id").select('DISTINCT ON ("sender_user_id") *')

  # @messages_send =  Message.where(["subject_user_id = :id", { id: current_user.id }])
  #                           .order("sender_user_id ASC, created_at DESC").select('DISTINCT ON ("sender_user_id") *')

  # @messages_received =  Message.where(["sender_user_id = :id", { id: current_user.id }])
  #                           .order("subject_user_id ASC, created_at DESC").select('DISTINCT ON ("subject_user_id") *')

  # @messages = @messages_send | @messages_received
   @messages = @messages.sort_by { |h| h[:created_at] }

  end

  def conversation
    if @messages_received.any?
    @messages_received.each do |mensaje|
      mensaje.marcarComoVisto
    end
    end
    @message.subject_user = User.find params[:id]
    @id_received = params[:id]
  end

  def create
    @message = Message.new(user_params)
    @message.sender_user = current_user
    @message.subject_user = User.find params[:subject_user]

    if @message.save
      redirect_to action: 'conversation', id: @message.subject_user.id
    else
      render 'conversation'
    end
  end

  def edit

  end

  def update
  end

  def destroy
  end

  def new_message_recurso
    @rec = Recurso.find(params[:id])
    @messages_received =  Message.where(["subject_user_id = :id", { id: current_user.id }])
                              .where(["sender_user_id = :id", { id: @rec.user.id}])
    @messages_sender =  Message.where(["subject_user_id = :id", { id: @rec.user.id }])
                            .where(["sender_user_id = :id", { id: current_user.id }])
    @messages = @messages_sender | @messages_received
    @messages = @messages.sort_by { |h| h[:created_at] }
    @message.sender_user = current_user
    @message.subject_user = @rec.user
    @message.text = "Hola, quiero ayudarte con tu recurso solicitado: \"" + @rec.nombre + "\". "
    render 'conversation', id: @rec.user.id
  end

  private

  def user_params
    params.require(:message).permit(:text,:subject_user)
  end

  def set_all_menssages
    @messages_received =  Message.where(["subject_user_id = :id", { id: current_user.id }])
                              .where(["sender_user_id = :id", { id: params[:id] }])
    @messages_sender =  Message.where(["subject_user_id = :id", { id: params[:id] }])
                            .where(["sender_user_id = :id", { id: current_user.id }])
    @messages = @messages_sender | @messages_received
    @messages = @messages.sort_by { |h| h[:created_at] }
  end

  def set_new_message
    @message = Message.new
  end

end
