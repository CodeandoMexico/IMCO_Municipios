function filterBusiness(){
  var line_id = $('#lines_filter').val();
  var uri = "?line_id=";

  // sending the selected value params if it's not an invalid id
  document.location.href = uri + line_id;
}
