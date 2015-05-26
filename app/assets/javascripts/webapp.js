var app = angular.module('miNegocio', []);

app.controller('ProcedureCtrl', ['$http', function($http){
  var self = this;

  self.initialize = function(){
    // the procedures may be formation steps
    // or procedures
    self.items = [];
  };

  self.update = function(userId, formationId, lineId, type){
    console.log({
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
      user_formation_step: {
        user_id: userId,
        formation_step_id: formationId,
        line_id: lineId,
        type_user_formation_step: type
      }
    };

    // Let's submit the checkbox info
    $http.post('/user_formation_steps', data)
    .success(function(data, statues, headers, config){
      // do something when the checkbox has beeen successfully submitted ...
      // e.g. strike the checklist item or show a message that it has been updated
    });
  }

  self.initialize();
}]);
