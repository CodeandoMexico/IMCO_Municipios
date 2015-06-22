var app = angular.module('miNegocio', []);

app.controller('ProcedureCtrl', ['$http', '$window', function($http, $window){
  var self = this;

  self.initialize = function(){
    // the procedures may be formation steps
    // or procedures
    self.items = [];
  };

  self.update = function(data){
    // Get token
    var csrfToken = angular.element('meta[name=csrf-token]')[0].content;

    // add the authenticity token
    data['authenticity_token'] = csrfToken;

    // Let's submit the checkbox info
    $http.post(data['path'], data)
    .success(function(data, status, headers, config){
      // do something when the checkbox has beeen successfully submitted ...
      // e.g. strike the checklist item or show a message that it has been updated
    });
  };

  self.redirect = function(path){
    // let's redirect to the given path
    $window.location.href = path + "?sign_in=true";
  };

  self.initialize();
}]);
