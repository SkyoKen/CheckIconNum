import controlP5.*;
//import processing.opengl.*;
ControlP5 cp5;
ControlGroup messageBox;
int messageBoxResult = -1;
String messageBoxString = "";
float t;
int page=0;
int id;
ShowInfo si;

void setup() {
  size(960, 540);
  cp5 = new ControlP5(this);
  si=new ShowInfo("Ver0.1", "https://github.com/SkyoKen/CheckIconNum", 16);

  createMain();
  createBar();
  createMessageBox();
}

void draw() {
  background(0);
  si.update();
}

void icon(boolean theValue) {
  println("got an event for icon", theValue);
} 
void createMain() {
  ControlGroup main = cp5.addGroup("Main", 20, 20, 18*50+20)
    .setBackgroundHeight(50*9-20)
    .setBackgroundColor(color(128, 100))
    .hideBar();

  for (int i=0; i<16; i++) {
    cp5.addTextlabel("x"+i)
      .setText(i<10?Integer.toString(i):String.valueOf((char)('A'+(i-10))) )
      .setPosition(i*50+50, 0)
      //  .setColor(color(#0476D9))
      .setFont(createFont("Consolas", 40))
      .moveTo(main)
      ;
  }
  for (int i=0, j=8; i<8; i++, j++) {
    cp5.addTextlabel("y"+i)
      .setText(Integer.toString(i))
      .setPosition(0, i*50+40)
      //   .setColor(color(#0476D9))
      .setFont(createFont("Consolas", 40))
      .moveTo(main)
      ;
    cp5.addTextlabel("y"+j)
      .setText(j<10?Integer.toString(j):String.valueOf((char)('A'+(j-10))) )
      .setPosition(0, i*50+40)
      //    .setColor(color(#0476D9))
      .setFont(createFont("Consolas", 40))
      .moveTo(main)
      .hide()
      ;
  }
  Group g=cp5.addGroup("g")
    .setPosition(30, 50)
    .hideBar()
    .moveTo(main);
  for (int i=0; i<525; i++) {
    int a=#00f000+i;
    cp5.addIcon("icon"+i, 10)
      .setPosition(i%16*50, i/16%8*50)
      .setFont(createFont("fontawesome-webfont.ttf", 40))
      .setFontIcons(a, a)
      .setFontIconSize(32)
      .setId(i)
      .hide()
      .setGroup(g)
      ;
  }

  for (int i=0; i<16*8; i++) {
    cp5.getController("icon"+i).show();
  }

  cp5.addButton("buttonDown", 0, 17*50, 50, 50, 150)
    .setFont(createFont("consolas", 20))
    .setCaptionLabel("↑")
    .setColorBackground(color(40))
    .setColorActive(color(20))
    .moveTo(main)
    ;
  cp5.addButton("buttonUp", 0, 17*50, 250, 50, 150)
    .setFont(createFont("consolas", 20))
    .setCaptionLabel("↓")
    .setColorBackground(color(40))
    .setColorActive(color(20))
    .moveTo(main)
    ;
}

void createBar() {
  ControlGroup bar = cp5.addGroup("Bar", 0, 50*9+5, 960)
    .setBackgroundHeight(60)
    .setBackgroundColor(color(128, 100))
    .hideBar()
    ;
  cp5.addIcon("getIcon", 0)
    .setPosition(50, 20)
    .setFont(createFont("fontawesome-webfont.ttf", 40))
    .setFontIcons(#00f02f, #00f02f)
    .setFontIconSize(50)
    .moveTo(bar)
    ;

  Textfield f= cp5.addTextfield("getIconNum", 150, 10, 150, 40)
    .setFont(createFont("Consolas", 32))
    .moveTo(bar)
    ;

  f.getCaptionLabel().setVisible(false);
  f.setColorForeground(color(20));
  f.setColorBackground(color(20));
  f.setColorActive(color(100));

  cp5.addButton("buttonSearch", 0, width-175*2, 10, 150, 40)
    .setFont(createFont("Consolas", 32))
    .setBroadcast(false)
    .setValue(0)
    .setBroadcast(true)
    .setCaptionLabel("Search")
    .setColorBackground(color(40))
    .setColorActive(color(20))
    .moveTo(bar)
    ;

  cp5.addButton("buttonExit", 0, width-175, 10, 150, 40)
    .setFont(createFont("Consolas", 32))
    .setBroadcast(false)
    .setValue(0)
    .setBroadcast(true)
    .setCaptionLabel("Exit")
    .setColorBackground(color(40))
    .setColorActive(color(20))
    .moveTo(bar)
    ;
}
void createMessageBox() {
  messageBox = cp5.addGroup("messageBox", width/2-270, height/2-120, 540)
    .setBackgroundHeight(240)
    .setBackgroundColor(color(0))
    .hideBar()
    .hide();

  cp5.addTextlabel("messageBoxLabel", "MessageBox", 190, 32)
    .setFont(createFont("Consolas", 32))
    .moveTo(messageBox);

  cp5.addIcon("icon", 10)
    .setPosition(50, 100)
    .setFont(createFont("fontawesome-webfont.ttf", 40))
    .setFontIcons(#00f196, #00f02f)
    .setSwitch(true)
    .setFontIconSize(100)  
    .moveTo(messageBox)
    ;


  Textfield f = cp5.addTextfield("inputbox", 180, 100, 150, 40);
  f.setFont(createFont("Consolas", 32));
  f.setText("#00f");
  f.getCaptionLabel().setVisible(false);
  f.moveTo(messageBox);
  f.setColorForeground(color(20));
  f.setColorBackground(color(20));
  f.setColorActive(color(100));

  cp5.addButton("buttonOK", 0, 100, 180, 150, 40)
    .setFont(createFont("Consolas", 32))
    .moveTo(messageBox)
    .setColorBackground(color(40))
    .setColorActive(color(20))
    .setBroadcast(false)
    .setValue(1)
    .setBroadcast(true)
    .setCaptionLabel("OK")
    ;
  cp5.addButton("buttonCancel", 0, 300, 180, 150, 40)
    .setFont(createFont("Consolas", 32))
    .moveTo(messageBox)
    .setBroadcast(false)
    .setValue(0)
    .setBroadcast(true)
    .setCaptionLabel("Cancel")
    .setColorBackground(color(40))
    .setColorActive(color(20))
    ;
}
void buttonOK(int theValue) {
  println("a button event from button OK.");
  messageBoxString = ((Textfield)cp5.getController("inputbox")).getText();
  String message=((Textfield)cp5.getController("inputbox")).getText();
  String str="";
  if (message.length()!=7 && !message.substring(0, 4).equals("#00f")) {
    str="error";
    return;
  } else {
    try {
      id=Integer.parseInt(message.substring(4), 16);
    }
    catch(Exception e) {
      println(e);
    }
  }
  print(Integer.parseInt(message.substring(4), 16));
  println(str);
  messageBoxResult = theValue;
  messageBox.hide();
}

void buttonCancel(int theValue) {
  messageBoxResult = theValue;
  messageBox.hide();
}
void inputbox(String theString) {
  //println("got something from the inputbox : "+theString);
  messageBoxString = theString;
  messageBox.hide();
}
void buttonUp() {
  page=min(4, ++page);
  pageUpdate();
}
void buttonDown() {
  page=max(0, --page);
  pageUpdate();
}
void pageUpdate() {
  for (int i=0; i<525; i++) {
    cp5.getController("icon"+i).hide();
  }
  for (int i=16*8*page; i<min(525, 16*8*(page+1)); i++) {
    cp5.getController("icon"+i).show();
  }
  for (int i=0; i<16; i++) {
    cp5.getController("y"+i).hide();
  }
  for (int i=0; i<8; i++) {
    cp5.getController("y"+(i+page%2*8)).show();
  }
}
void buttonSearch() {
  messageBox.show();
}
void buttonExit() {
  exit();
}

void controlEvent(ControlEvent theEvent) {
  if (theEvent.isController()) {
    if (theEvent.getController().getId()==-1)return;
    Icon icon=(Icon)theEvent.getController();
    if (icon.isOn()) {
      getItem(icon.getId());
    }
  }
}
void getItem(int id) {
  ((Textfield)cp5.getController("getIconNum")).setText("#00f"+String.format("%03x", id));
  ((Icon)cp5.getController("getIcon")).setFontIcons(#00f000+id, #00f000+id);
}
