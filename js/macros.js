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
  return '<div class="center"> <img class="photo" src="' +  url  + '" style="width:' + percentage  + '; border: 4px solid white;" ><span class="bottomcap">' + person + ' <br> ' + dates +  '</span></div>' ;
  
};

remark.macros.credited = function (caption, percentage, color) {
  var url = this;
  return '<div class="center"> <img class="photo" src="' +  url + '" style="width:' + percentage  + '; border: 4px solid ' + color + ' margin-bottom: 5px;" ><span class="image-credits">' + caption + '</span></div>' ;
  
};

remark.macros.vspace = function (size) {
  return '<div style="height: ' + size + 'px;"><br></div>';
};


remark.macros.colorbox = function (x, y, boxWidth, boxType) {
  var content = this;
  return '<div class="' + boxType + '" style="position: absolute; left:' + x + '; top:' + y + '; width: ' + boxWidth +  ';"><p class="inner">'  + content + '</p></div>';

};
