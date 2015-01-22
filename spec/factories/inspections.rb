FactoryGirl.define do
  factory :inspection do
    sequence(:nombre) { |n| "Inspection No. #{n}"}
    materia "Lorem ipsum dolor sit amet."
    duracion "Lorem ipsum dolor sit amet."
    norma "Lorem ipsum dolor sit amet."
    durante "Lorem ipsum dolor sit amet, consectetur cras amet."
    despues "Lorem ipsum dolor sit amet, consectetur cras amet."
    sancion "Lorem ipsum dolor sit amet, consectetur cras amet."
    association :dependency
  end
end
