// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require angular
//= require bootstrap-sprockets
//= require bootstrap-switch
//= require chosen-jquery
//= require underscore
//= require gmaps/google
//= require webapp
//= require_tree ./public
//= require_tree .

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
  loadProcedureLinesTooltips();
};

$(document).ready(loadComponents);
$(document).on('page:load', loadComponents);