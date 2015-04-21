  var loadProcedureLinesTooltips = function() {
    $(".tip-top").tooltip({placement : 'top'});
    $(".tip-right").tooltip({placement : 'right'});
    $(".tip-bottom").tooltip({placement : 'bottom'});
    $(".tip-left").tooltip({ placement : 'left'});

    $('[data-toggle="tooltip"]').tooltip();
  };
