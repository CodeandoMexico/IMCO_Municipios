var app = angular.module('miNegocio', []);

app.controller('ProcedureCtrl', ['$http', '$window', function($http, $window){
  var self = this;

  self.initialize = function(){
    // the procedures may be formation steps
    // or procedures
    self.items = [];
  };

  self.update = function(done, userId, formationId, lineId, type, path){
    console.log({
      done: done,
      userId: userId,
      formationId: formationId,
      lineId: lineId,
      type: type
    });

    // Get token
    var csrfToken = angular.element('meta[name=csrf-token]')[0].content;

    // Checkbox id and state to change
    var data = {
      authenticity_token: csrfToken,
      done: done,
      user_formation_step: {
        user_id: userId,
        formation_step_id: formationId,
        line_id: lineId,
        type_user_formation_step: type
      }
    };

    // Let's submit the checkbox info
    $http.post(path, data)
    .success(function(data, statues, headers, config){
      // do something when the checkbox has beeen successfully submitted ...
      // e.g. strike the checklist item or show a message that it has been updated
    });
  };

  self.redirect = function(path){
    // let's redirect to the given path
    $window.location.href = path;
  };

  self.initialize();
}]);
