module ProcedureLinesHelper
   def tipo(t)
            if t== 'TM'
             'Moral'
            elsif t == 'TF'
              'Física'
            else
              'Ambas'
            end
          end
end

def valida_tipo_procedure(tipo_procedure, tipo)
  if tipo_procedure =='TM' && tipo == 'TM'
    return true
  end
  if tipo_procedure =='TF' && tipo == 'TF' 
    return true
  end
  if tipo_procedure =='A' || tipo == 'A'
    return true
  end
  return false
end
