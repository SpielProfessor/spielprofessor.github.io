// Fragen: 10 / +10 / -5 
var fragen = ["Wie alt ist die älteste Höhlenmalerei?", "Wie lange hat das alte Ägypten als großmacht Überlebt?", "Welches dieser Bauwerke gehörte nicht zu den Weltwundern der Antike?", "Wie viele Hauptgötter gab es im antiken Griechenland?", "Wie viele Länder waren unter Römischer Herrschaft zur Zeit seiner größten Ausdehnung?", "Wann fing der erste Kreuzzug an?", "Wann wurde der Amerikanische Kontinent entdeckt?", "Wie viele Soldaten kamen im amerikanischen Buergerkrieg ums Leben?", "Welches Land wurde im 2. Weltkrieg mit atombomben bebombt?", "Welches land hat die Atombombe abgeworfen?", "Vielen Dank fürs spielen!"];
var lastQuestion = 11;
var answerIndex = [
  ["45500", "43900", "65000", "32000"],
  ["etwa 3000 Jahre", "etwa 4000 Jahre", "etwa 2000 Jahre", "etwa 5000 Jahre"],
  ["Koloss von Rhodos", "Leuchtturm von Pharos", "Das Kolloseum", "Hängenden Gärten von Babylon"],
  ["12", "10", "3", "7"],
  ["31", "25", "19", "46"],
  ["1095", "1105", "1080", "1090"],
  ["1490", "1496", "1492", "1500"],
  ["540000", "740000", "620000", "810000"],
  ["Japan", "Russland", "Deutschland", "Frankreich"],
  ["Deutschland", "Russland", "USA", "Großbritanien"],
  ["1","1","1", "1"]
];
var trues=[1,2,3,1,4,1,3,3,1,3];
var points = 0;
var index = 1;
function draw() {

  document.getElementById("score").innerHTML = "Geschichte - Das Quiz | Punkte: " + points;
  document.getElementById("cFrage").innerHTML = "Frage nr. " + index + " - " + fragen[index - 1];
  update();
}
function update(){
  document.getElementById("b1").innerHTML=answerIndex[index-1][0];
  document.getElementById("b2").innerHTML=answerIndex[index-1][1];
  document.getElementById("b3").innerHTML=answerIndex[index-1][2];
  document.getElementById("b4").innerHTML=answerIndex[index-1][3];
}
function validate(id){
  if (index<lastQuestion){
  if (id==trues[index-1]){
    points+=10;
    document.getElementById("state").innerHTML="Right! +10 points!";
  } else {
    points-=5;
    document.getElementById("state").innerHTML="Wrong! -5 points!";
  }
  index++;
  draw();
  if (index==lastQuestion){
    stop();
  }
  } else {
    points=0;
    index=1;
    draw();
  }
}
function stop() {
  if (points <=-50){
    var note = "7?";
    document.getElementById("state").innerHTML="Es gibt note 7???";
  } else if (points <= 10) {
    var note = 6;
  } else if (points < 25) {
    var note = 5;
  } else if (points <= 50) {
    var note = 4;
  } else if (points <= 69) {
    var note = 3;
  } else if (points <= 85) {
    var note = 2;
  } else {
    var note = 1;
  }
  document.getElementById("cFrage").innerHTML = "Vielen Dank für's spielen";
    document.getElementById("score").innerHTML = "Geschichte - Das Quiz | Punkte: " + points + " | Note: " + note;
  document.getElementById("b1").innerHTML="Play again";
  document.getElementById("b2").innerHTML="Play again";
  document.getElementById("b3").innerHTML="Play again";
  document.getElementById("b4").innerHTML="Play again";
  
}