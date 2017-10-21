String[] words;
String nextWord;
int wordsIndex = 0;
boolean painting = false;

void mousePressed() {
  painting = !painting;
}

void setup() {
  size(800,800);
  //fullScreen();
  background(246);
  
  frameRate(15); // slow it down!
  textAlign(CENTER);
  
// get data from WL API
String WLURL = "https://www.wolframcloud.com/objects/2224626a-3f76-4694-acfa-fbd415ea7581?x=";
String source = "http://www.papert.org/articles/HardFun.html"; // allows me to change the source later as needed
String[] lines = loadStrings(WLURL + source);
String textString = join(lines,"");
println(textString);

// Parse data
String[] lines2 = split(textString,"&quot;");

// remove words with special characters
for(int i = 0; i<lines2.length; i++) {
  if(match(lines2[i],"&")!= null) {
    lines2[i] = "";
  }
}

textString = join(lines2,"");
// remove extra data from front and back...
textString = textString.substring(textString.indexOf("{")+1,textString.indexOf("}"));

// put data into an Array
words = split(textString,",");

// Debugging
//println(textString);
//println(textString);
}

// paint with data
void draw() {
  textSize(random(20,200));
  fill(random(255),random(255),random(255));
  wordsIndex++;
  if(wordsIndex > words.length-1) {
    wordsIndex = 0;
  }
  nextWord = words[wordsIndex];
  if(painting) {
   text(nextWord,mouseX,mouseY);
 }
}