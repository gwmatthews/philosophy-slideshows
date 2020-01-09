remark.macros.scale = function (percentage, frameColor) {
  var url = this;
  return '<img class="photo" src="' + url + '" style="width: ' + percentage + ';border: 7px solid ' + frameColor + ';" alt="photo" />';
};


remark.macros.jump = function (linkText) {
  var url = this;
  return '<a href="' + url + '"target="_blank">' + linkText + '</a>';
};


remark.macros.portrait = function (person, dates, percentage) {
  var url = this;
  return '<div class="center"> <img class="photo" src="' +  url  + '" style="width:' + percentage  + '; border: 4px solid white;" ><span class="bottomcap">' + person + ': <br> ' + dates +  '</span></div>' ;
  
};


/*



*/
