class BecadosPorFundacion < ActiveRecord::Base
  belongs_to :becado, foreign_key: "becado_id", class_name: "User"
  belongs_to :fundacion, foreign_key: "fundacion_id", class_name: "User"

  def name
    @user = User.find(self.becado_id)
    @user.nameAndLastname
  end

end
