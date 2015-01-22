require 'rails_helper'

feature 'A visitor enters the page' do
  attr_reader :city, :city_with_no_inspections, :inspections

  before(:all) do
    @city = create :municipio
    @city_with_no_inspections = create :municipio
    dependency = create :dependency, municipio: city
    @inspections = []
    3.times { @inspections << create(:inspection, dependency: dependency) }
  end

  scenario 'and goes to the city inspections list' do
    # Given a city's, go to the inspections page
    visitor_navigates_to_inspections_from(city)

    # Are we in the correct path?
    expect(current_path).to eq municipio_inspections_path(city)

    # Check that there is a listing with all 3 inspections created before
    all_inspections_make_an_appereance

    # save_and_open_page # uncomment to view webpage output snapshot
  end

  scenario 'a visits the last inspection from the list' do
    visitor_navigates_to_inspections_from(city)

    # click on the last inspection from the list
    visit_last_inspection_detail

    # let's check that the path is equal to the the last inspection :show path
    # for this resource
    expect(current_path).to eq(municipio_inspection_path(city, last_inspection))

    # let's check for 'some' information of the resource
    expect(page).to have_content last_inspection.nombre
    expect(page).to have_content last_inspection.materia
    expect(page).to have_content last_inspection.duracion

    # save_and_open_page # uncomment to view webpage output snapshot
  end

  scenario 'and searches for a given inspection and finds one match' do
    visitor_navigates_to_inspections_from(city)

    # search from the inspection list the inspection given as a parameter
    search_for(last_inspection)

    # let's verify the site 'only' gave us the last inspection
    expect(page).to have_content last_inspection.nombre

    all_inspections_make_an_appereance_except_for last_inspection

    # save_and_open_page # uncomment to view webpage output snapshot
  end

  scenario 'and goes to the inspection site for a city and sees there aren\'t inspection available' do
    visitor_navigates_to_inspections_from city_with_no_inspections
    expect(page).to have_content 'No encontramos inspecciones en este municipio'

    # save_and_open_page # uncomment to view webpage output snapshot
  end


  def all_inspections_make_an_appereance
    inspections.each do |inspection|
      expect(page).to have_content inspection.nombre
    end
  end

  def all_inspections_make_an_appereance_except_for(inspection_that_should_be_absent)
    inspections.each do |inspection|
      if inspection != inspection_that_should_be_absent
        # use of to_not, should be used only sporadically
        expect(page).to_not have_content inspection.nombre
      end
    end
  end

  def search_for(inspection)
    # Name format is like this 'Inspection No. 5'
    inspection_num = inspection.nombre

    # fill the search bar
    fill_in 'q', with: inspection.nombre[inspection_num.length - 1]
    click_on 'Buscar'
  end

  def visitor_navigates_to_inspections_from(current_city)
    visit root_path
    select current_city.nombre, from: 'post_municipio'
    click_on 'Continuar'
    click_on 'Inspecciones'
  end

  def visit_last_inspection_detail
    click_on last_inspection.nombre
  end

  def last_inspection
    inspections.last
  end
end
