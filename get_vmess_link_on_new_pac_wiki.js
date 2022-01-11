let text="";
document.querySelectorAll("p").forEach(function(item){if(item.innerText.startsWith("vmess")){text+=item.innerText+"\n"}});
copy(text);
