class Message < ActiveRecord::Base

  belongs_to :sender_user , class_name: 'User', foreign_key: 'sender_user_id'
  belongs_to :subject_user , class_name: 'User', foreign_key: 'subject_user_id'

  def marcarComoVisto
      update_attribute(:is_view, true)
  end
end
