class Reminders < ActiveRecord::Base
  validates_presence_of :name, :message => 'Debes escribir el nombre del documento.'
  validates_length_of :name, :minimum => 3, :message => 'El nombre debe tener por lo menos 3 caracteres.'
  validates_format_of :name, :with => /\A[a-zA-Z áéíóúÁÉÍÓÚñÑ]+\z/, :message => "El nombre solo debe tener letras"

  validates_presence_of :license, :message => 'Debes escribir el número de la licencia'
  validates_format_of :license, :with => /\A[a-zA-Z0-9]+\z/, :message => "El número de la licencia solo debe tener letras y número"
 
   validates_presence_of :until_to, :message => 'Debes escribir la fecha de vencimiento', on:  :update

   belongs_to :user
end
