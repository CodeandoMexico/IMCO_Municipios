class FormationStep < ActiveRecord::Base
    self.inheritance_column = nil

      belongs_to :municipio
end
