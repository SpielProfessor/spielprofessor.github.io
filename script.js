function isDarkModeEnabled() {
    return window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches
}
if (isDarkModeEnabled()){
    var style=1;
} else {
    var style=0;
}
if (style==0){
document.getElementById("sheet").setAttribute("href", "style-light.css");
} else {
    document.getElementById("sheet").setAttribute("href", "style-dark.css");
}
function switchTheme(){
    if (style==0){
        style=1;
    } else {
        style=0;
    }
    if (style==0){
        document.getElementById("sheet").setAttribute("href", "style-light.css");
    } else {
        document.getElementById("sheet").setAttribute("href", "style-dark.css");
    }
}