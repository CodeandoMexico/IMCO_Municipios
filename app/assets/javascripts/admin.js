//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require bootstrap-switch
//= require metisMenu/dist/metisMenu.min
//= require raphael/raphael-min
//= require sb-admin-2
//= require chosen-jquery
//= require_tree ./admin

var loadChosen = function(){
    $('.chosen-select').chosen({
       allow_single_deselect: true,
       no_results_text: 'No hay resultados',
       placeholder_text: 'Selecciona una opción',
       width: '500px'
    });
};

var loadComponents = function () {
  loadChosen();
};

$(document).ready(loadComponents);
$(document).on('page:load', loadComponents);
