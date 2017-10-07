class Payment < ActiveRecord::Base

  require 'todo_pago_conector'
  require 'socket'

  def mark_payment()
    self.state = true
    self.save
    self
  end

  def mark_payment_todopago(requestKey,authorizationKey)
    self.external_id = authorizationKey
    self.external_referent = requestKey
    self.state = true
    self.save
    self
  end

  def open_todopago(user,curso)

    j_wsdls = {
        #'Authorize'=> 'https://developers.todopago.com.ar/services/t/1.1/Authorize?wsdl'
        'Authorize'=> "#{Rails.root}/lib/Authorize.wsdl"
    }

    j_header_http = {
        "Authorization"=>"TODOPAGO 3237ab5793134e49a1e245f53ad8f9e5" #curso.user.payment_type.authorization
    }

    end_point = 'https://developers.todopago.com.ar/'

    conector = TodoPagoConector.new(j_header_http, j_wsdls, end_point)

    optionsSAR_operacion = Hash.new

    optionsSAR_operacion[:MERCHANT] = "15883" #curso.user.payment_type.merchant

    optionsSAR_operacion[:OPERATIONID] = self.id.to_s
    optionsSAR_operacion[:CURRENCYCODE] = "032"
    optionsSAR_operacion[:AMOUNT] = self.redondear_amount

    optionsSAR_operacion[:CSBTCITY]= user.location.city #user.payment_type.ciudad
    optionsSAR_operacion[:CSBTCOUNTRY]= "AR"
    optionsSAR_operacion[:CSBTEMAIL]= user.email
    optionsSAR_operacion[:CSBTFIRSTNAME]= user.name
    optionsSAR_operacion[:CSBTLASTNAME]= user.lastname
    optionsSAR_operacion[:CSBTPHONENUMBER]= "541160913988" #user.telefono
    optionsSAR_operacion[:CSBTPOSTALCODE]= "1010" #user.cod_postal
    optionsSAR_operacion[:CSBTSTATE]= "B"
    optionsSAR_operacion[:CSBTSTREET1]= user.location.address

    ip = Socket.ip_address_list.detect{|intf| intf.ipv4_private?}

    optionsSAR_operacion[:CSBTCUSTOMERID]= user.id.to_s
    optionsSAR_operacion[:CSBTIPADDRESS]= ip.ip_address
    optionsSAR_operacion[:CSPTCURRENCY]= "ARS"
    optionsSAR_operacion[:CSPTGRANDTOTALAMOUNT]= self.redondear_amount
    optionsSAR_operacion[:CSMDD6]= ""
    optionsSAR_operacion[:CSMDD7]= ""
    optionsSAR_operacion[:CSMDD8]= ""
    optionsSAR_operacion[:CSMDD9]= ""
    optionsSAR_operacion[:CSMDD10]= ""
    optionsSAR_operacion[:CSMDD11]= ""

    optionsSAR_operacion[:CSSTCITY]= user.location.city #user.payment_type.ciudad
    optionsSAR_operacion[:CSSTCOUNTRY]= "AR"
    optionsSAR_operacion[:CSSTEMAIL]= user.email
    optionsSAR_operacion[:CSSTFIRSTNAME]= user.name
    optionsSAR_operacion[:CSSTLASTNAME]= user.lastname
    optionsSAR_operacion[:CSSTPHONENUMBER]= "541160913988" #user.payment_type.telefono
    optionsSAR_operacion[:CSSTPOSTALCODE]= "1010" #user.payment_type.cod_postal
    optionsSAR_operacion[:CSSTSTATE]= "B" #user.payment_type.estado
    optionsSAR_operacion[:CSSTSTREET1]= user.location.address #user.payment_type.direccion

    optionsSAR_operacion[:CSITPRODUCTCODE]= curso.nombre+"-"+curso.id.to_s
    optionsSAR_operacion[:CSITPRODUCTDESCRIPTION]= curso.descripcion
    optionsSAR_operacion[:CSITPRODUCTNAME]= curso.nombre
    optionsSAR_operacion[:CSITPRODUCTSKU]= "CU"+curso.id.to_s
    optionsSAR_operacion[:CSITTOTALAMOUNT]= self.redondear_amount
    optionsSAR_operacion[:CSITQUANTITY]= "1"
    optionsSAR_operacion[:CSITUNITPRICE]= self.redondear_amount

    optionsSAR_operacion[:CSMDD12]= ""
    optionsSAR_operacion[:CSMDD13]= ""
    optionsSAR_operacion[:CSMDD14]= ""
    optionsSAR_operacion[:CSMDD15]= ""
    optionsSAR_operacion[:CSMDD16]= ""

    optionsSAR_operacion[:AVAILABLEPAYMENTMETHODSIDS]= ""
    optionsSAR_operacion[:PUSHNOTIFYMETHOD]= ""
    optionsSAR_operacion[:PUSHNOTIFYENDPOINT]= ""
    optionsSAR_operacion[:PUSHNOTIFYSTATES]= ""
    optionsSAR_operacion[:MAXINSTALLMENTS]= "1"

    optionsSAR_comercio = Hash.new


    optionsSAR_comercio[:Security]="1234567890ABCDEF1234567890ABCDEF" #API KEY
    optionsSAR_comercio[:MERCHANT]= "15883" #curso.user.payment_type.merchant

    optionsSAR_comercio[:EncodingMethod]="XML"
    optionsSAR_comercio[:URL_OK]= "http://sumemosunomas.herokuapp.com//mark_payment_todopago/"+self.id.to_s+"/OK/payment"
    optionsSAR_comercio[:URL_ERROR]= "http://sumemosunomas.herokuapp.com//mark_payment_todopago/"+self.id.to_s+"/ERROR/payment"
    #optionsSAR_comercio[:URL_OK]= "http://localhost:3000//mark_payment_todopago/"+self.id.to_s+"/OK/payment"
    #optionsSAR_comercio[:URL_ERROR]= "http://localhost:3000//mark_payment_todopago/"+self.id.to_s+"/ERROR/payment"
    #optionsSAR_comercio[:EMAILCLIENTE]= curso.user.email
    optionsSAR_comercio[:Session]= "ABCDEF-1234-12221-FDE1-00000200"

    response = conector.sendAuthorizeRequest(optionsSAR_comercio,optionsSAR_operacion)
    @responseJson = JSON.parse(response)
    self.description = @responseJson["envelope"]["body"]["send_authorize_request_response"]["status_code"] +" "+@responseJson["envelope"]["body"]["send_authorize_request_response"]["status_message"]

    if(@responseJson["envelope"]["body"]["send_authorize_request_response"]["status_code"] == "-1")
      self.external_id = @responseJson["envelope"]["body"]["send_authorize_request_response"]["request_key"]
      self.external_referent= @responseJson["envelope"]["body"]["send_authorize_request_response"]["public_request_key"]
    end
    self.save
    return @responseJson
  end

  def redondear_amount
    temp = self.amount.to_s.length
    sprintf("%#{temp}.2f",self.amount).to_s
  end

end
