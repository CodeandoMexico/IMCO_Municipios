module FormationStepsHelper

def type(tipo)
  tipo == 'AF'? 'Física' : 'Moral'
end

def valida_tipo(tipo_procedure, tipo)
  if tipo_procedure =='TM' && tipo == 'AM'
    return true
  end
  if tipo_procedure =='TF' && tipo == 'AF' 
    return true
  end
  if tipo_procedure =='A' || tipo == 'A'
    return true
  end
  return false
end

  # def heading_search(name)
  #    "Apertura de #{name}"
  #  end

   
  #  def subheading_search(type)
  #    "Para persona #{type == 'AF'? 'física' : 'moral'}"
  #  end

end