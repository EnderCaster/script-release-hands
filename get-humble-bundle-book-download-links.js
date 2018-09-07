var hrefs='';
$('.download').children().children('a').each(function(){hrefs+=this.href;hrefs+="<br />"})
document.write(hrefs)
