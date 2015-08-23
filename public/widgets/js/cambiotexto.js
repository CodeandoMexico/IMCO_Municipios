$(document).ready(function cambioTexto(){
    var cnt=0, texts=[];
$(".textContent").each(function() {
  texts[cnt++]=$(this).text();
});
function slide() {
  if (cnt>=texts.length) cnt=0;
  $('#textMessage').html(texts[cnt++]);
  $('#textMessage')
    .fadeIn('slow').animate({opacity: 1.0}, 35000).fadeOut('slow', 
     function() {
       return slide()
     }
  );      
}      
slide();       
});