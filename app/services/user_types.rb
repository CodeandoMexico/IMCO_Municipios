module UserTypes 
  def self.type_of_people_formation_step
    ['AM' ,  'AF','A']
  end

  def self.type_of_people_procedures
    ['TM' ,  'TF','A']
  end
  def self.type_of_sare
        ['0','1']
  end
  def self.type_of_procedure_formation_step
    ['Federal' , 'Estatal']
  end
  def self.type_of_category
        ['Constituye tu empresa','Administra tu empresa','Crece y financia tu empresa','Construcción','Cierre de giro de tu empresa']
  end

  def self.reminders_category
    [{"name"=>"Recordar un mes antes que venza", "id"=>"1"}, {"name"=>"Recordar cada mes", "id"=>"2"}, {"name"=>"Recordar cada quincena", "id"=>"3"}, {"name"=>"Recordar cada semana", "id"=>"4"}]
  end
end 
