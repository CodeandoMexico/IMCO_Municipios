function filterBusiness(){
  var line_id = $('#lines_filter').val();
  var uri = "?line_id=";

  // sending the selected value params if it's not an invalid id
  document.location.href = uri + line_id;
}

function pretty_business_name(business){
  if( valuePresent(business['business_name']) ){
    return business['business_name'];
  }
  else if( valuePresent(business['name']) ){
    return valuePresent(business['name'])
  }
  else if( valuePresent(business['email']) ){
    return business['email'];
  }

  return "";
}
