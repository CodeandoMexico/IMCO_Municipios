function valuePresent(value){
  console.log(value);
  if(value != null && value != undefined && value != ''){
    return true;
  }
  return false;
}

function fetchValue(value, notAvailableValue){
  if(valuePresent(value)){
    return value;
  }
  return notAvailableValue;
}
