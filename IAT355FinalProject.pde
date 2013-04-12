/* ==================================================
 * IAT355 Spring 2013 - Final Project
 * April 11, 2013
 *
 * Version 2.0
 *
 * Stanley Lai Zhen-Yu (zlai)
 * Ooi Yee Loong
 * ================================================== */

/* ==================================================
 * Imports
 * ================================================== */
// Java
import java.util.Map;

// Unfolding for Processing
import de.fhpotsdam.unfolding.mapdisplay.*;
import de.fhpotsdam.unfolding.utils.*;
import de.fhpotsdam.unfolding.marker.*;
import de.fhpotsdam.unfolding.tiles.*;
import de.fhpotsdam.unfolding.interactions.*;
import de.fhpotsdam.unfolding.ui.*;
import de.fhpotsdam.unfolding.*;
import de.fhpotsdam.unfolding.core.*;
import de.fhpotsdam.unfolding.data.*;
import de.fhpotsdam.unfolding.geo.*;
import de.fhpotsdam.unfolding.texture.*;
import de.fhpotsdam.unfolding.events.*;
import de.fhpotsdam.utils.*;
import de.fhpotsdam.unfolding.providers.*;

// OpenGL
import processing.opengl.*;
import codeanticode.glgraphics.*;

// ControlP5
import controlP5.*;



/* ==================================================
 * Init
 * ================================================== */
// Map
UnfoldingMap map;

// Data Files
String[] schoolInfoDataFile;
String[] achievementSurveyDataFile;
String[] gradRateDataFile;

// Visualization vars
float maxVar, minVar;

// ControlP5 objects
ControlP5 cp5;
RadioButton schoolYearSelect;

// Array of School objects
School[] schools;

// debug
Boolean renderMarkers;

/* ==================================================
 * Setup Method
 * ================================================== */
void setup() {
  // Set false to prevent file processsing. To allow for quick UI debugging
  renderMarkers = true;
  
  // Load up screen
  size(1280, 700, GLConstants.GLGRAPHICS);
  
  // init vars
  maxVar = 0;
  minVar = 100;
  
  if (renderMarkers) {  // for debug
    // Load and crunch CSV file
    schoolInfoDataFile = loadStrings("BCSchoolInfo_10012012.csv");
    achievementSurveyDataFile = loadStrings("AchievementCombinedParentsCurr.csv");
    gradRateDataFile = loadStrings("FirstTimeG12GradRate-SchoolsOnly_2011-2012.csv");
    processSchoolInfoData(schoolInfoDataFile);
    processGradRateData(gradRateDataFile);
  }
  
  // Init Unfolding Map
  map = new UnfoldingMap(this, new OpenStreetMap.CloudmadeProvider("dcd2157d99f04bbf97922278fd9584b8", 998));
  map.zoomAndPanTo(new Location(49.21, -122.9), 11); // Position map at Vancouver
  MapUtils.createDefaultEventDispatcher(this, map); // Enable basic user interactions
  map.setTweening(true); // Animate all map movements
  
  if (renderMarkers) {  // for debug
  // Draw school markers.
  // Should always be the last statement, since School class needs to be fully populated with data first
    addMarkerBySchoolYear("2011/2012");
  }
  
  // Add controlP5 filter controls
  initControlP5();
}



/* ==================================================
 * Draw Method
 * ================================================== */
void draw() {
  // Redraw Unfolding Map
  map.draw();
  
  /*
  // Display co-ordinates at mouse
  Location pointerLoc = map.getLocation(mouseX, mouseY);
  fill(255);
  text(pointerLoc.getLat() + ", " + pointerLoc.getLon(), mouseX, mouseY);
  */
  
  if (renderMarkers) {  // for debug
    for (Marker m : map.getMarkers()) {
      updateMarker(m);
    }
  }
  
  // Draw global UI elements
  drawUI();
}



/* ==================================================
 * Event Handler Methods
 * ================================================== */
void mouseMoved() {
  Marker hitMarker = map.getFirstHitMarker(mouseX, mouseY);
  if (hitMarker != null) {
        // Select current marker 
        hitMarker.setSelected(true);
    } else {
        // Deselect all other markers
        for (Marker marker : map.getMarkers()) {
            marker.setSelected(false);
        }
    }
}
 
 
 
/* ==================================================
 * Rendering Methods
 * ================================================== */
// Add all school location markers to map
void addSchoolMarkers() {
  for (int i=0; i < schools.length; i++) {
    schools[i].addMarkerTo(map);
  }
}

// Update markers
void updateMarker(Marker m) {
  if(m.isSelected()) {
    fill(255);
    text(m.getProperties().get("NAME").toString(), mouseX, mouseY);
  }
}

void reloadMarkersBySchoolYearIndex(int i) {
  map.getLastMarkerManager().clearMarkers();
  addMarkerBySchoolYearIndex(i);
}

// add marker to map if grad rate values are available for that school year
void addMarkerBySchoolYear(String schoolYear) {
  for (int i=0; i < schools.length; i++) {
    if (schools[i].getGradRate(schoolYear) > 0) {
      schools[i].addMarkerTo(map);
    }
  }
}
void addMarkerBySchoolYearIndex(int index) {
  for (int i=0; i < schools.length; i++) {
    if (schools[i].getGradRate(index) > 0) {
      schools[i].addMarkerTo(map);
    }
  }
}


/* ==================================================
 * Rendering Methods
 * ================================================== */
void drawUI() {
  fill(color(51));
  rect(0, 600, 1280, 100);
}



/* ==================================================
 * ControlP5 Methods
 * ================================================== */
void initControlP5() {
  cp5 = new ControlP5(this);
  schoolYearSelect = cp5.addRadioButton("schoolYearSelect")
                        .setPosition(20, 630)
                        .setSize(20, 20)
                        .setItemsPerRow(8)
                        .setSpacingColumn(65)
                        .setSpacingRow(3)
                        .addItem("1996/1997", 0)
                        .addItem("1997/1998", 1)
                        .addItem("1998/1999", 2)
                        .addItem("1999/2000", 3)
                        .addItem("2000/2001", 4)
                        .addItem("2001/2002", 5)
                        .addItem("2002/2003", 6)
                        .addItem("2003/2004", 7)
                        .addItem("2004/2005", 8)
                        .addItem("2005/2006", 9)
                        .addItem("2006/2007", 10)
                        .addItem("2007/2008", 11)
                        .addItem("2008/2009", 12)
                        .addItem("2009/2010", 13)
                        .addItem("2010/2011", 14)
                        .addItem("2011/2012", 15)
                        .activate("2011/2012");
}

// CP5 event handler
void controlEvent(ControlEvent theControlEvent) {
  if(theControlEvent.isFrom("schoolYearSelect")) {
    reloadMarkersBySchoolYearIndex(int(theControlEvent.getValue()));
  }
}
 
 
/* ==================================================
 * Data Processing Methods
 * ================================================== */
// Process school info by creating school objects based on provided info
void processSchoolInfoData(String[] file) {
  schools = new School[file.length-1];
  
  String[] columnNames = split(file[0], ",");
  int nameColumn = searchForColumnName("SCHOOL_NAME", columnNames);
  int schoolNumberColumn = searchForColumnName("SCHOOL_NUMBER", columnNames);
  int latColumn = searchForColumnName("SCHOOL_LATITUDE", columnNames);
  int lonColumn = searchForColumnName("SCHOOL_LONGITUDE", columnNames);
  
  // iterate through input data and populate School object
  for (int i=1; i < file.length; i++) {
    String[] row = split(file[i], ",");
    schools[i-1] = new School(row[nameColumn],
                              int(row[schoolNumberColumn]),
                              float(row[latColumn]),
                              float(row[lonColumn])
                              );
  }
}

// Search graduation rate data and populate school objects with matched info
void processGradRateData(String[] file) {
  
  // pick out column numbers of specific columns
  String[] columnNames = split(file[0], ",");
  int qForEachSchool = 4; // how many survey questions are there for each school?
  int schoolNumberColumn = searchForColumnName("SCHOOL_NUMBER", columnNames);
  int schoolYearColumn = searchForColumnName("SCHOOL_YEAR", columnNames);
  int valueColumn = searchForColumnName("MEASURE_VALUE", columnNames);
    
  // begin iterating through array of School objects
  for (int i=0; i < schools.length; i++) {
    int workingSchoolNumber = schools[i].getSchoolNumber();
    boolean foundMsk = false;
    
    // iterate through each row of input file information
    for (int j=1; j < file.length; j++) {
      String[] row = split(file[j], ",");
      
      // check if file's school number matches current school
      if (int(row[schoolNumberColumn]) == workingSchoolNumber) {
        int value = int(row[valueColumn]);
        if (value < 0) {
          schools[i].setGradRate(row[schoolYearColumn], -1);
        } else {
          schools[i].setGradRate(row[schoolYearColumn], value);
        }
      }
    }
  }
}

// Search achievement survey data and populate school objects with matched info
void processAchieveSurveyData(String[] file) {
  String[] columnNames = split(file[0], ",");
  
  int qForEachSchool = 4; // how many survey questions are there for each school?
  int schoolNumberColumn = searchForColumnName("SCHOOL_NUMBER", columnNames);
  int valueColumn = searchForColumnName("MANY_OR_ALL_PCT", columnNames);
    
  // begin iterating through array of School objects
  for (int i=0; i < schools.length; i++) {
    int workingSchoolNumber = schools[i].getSchoolNumber();
    int valueTotal = 0;
    int valueAverage = 0;
    boolean foundMsk = false;
    
    // iterate through each row of input file information
    for (int j=1; j < file.length; j++) {
      String[] row = split(file[j], ",");
      
      // check if file's school number matches current school
      if (int(row[schoolNumberColumn]) == workingSchoolNumber) { 
        valueTotal += int(row[valueColumn]);
      }
    }
    
    // Calculate average of value
    valueAverage = valueTotal/qForEachSchool;
    
    // print(workingSchoolNumber + " : ");
    // println(valueTotal + "/" + qForEachSchool + " = " + valueAverage);
    
    // populate School object with average of achievement survey scores
    schools[i].setAchievementValue(valueAverage);
    
    // Update MaxMin Values
    updateMaxMin(valueAverage);
  }
  
  println("Max: " + maxVar);
  println("Min: " + minVar);
}

// Searches array for a string, and returns the column number it belongs to
int searchForColumnName(String name, String[] row) {
  // Iterate through provided row
  for (int i=0; i < row.length; i++) {
    // Check if content at this index matches provided string
    String[] testString = match(row[i], name);
    // If not null, then a match was found. Return the current index
    if (testString != null) { return i; }
  }
  return 99;
}

// Take input value, and updates max and min values
void updateMaxMin(float i) {
    if (i > maxVar) maxVar = i;
    if (i < minVar) minVar = i;
}



/* ==================================================
 * Getter & Setter Methods
 * ================================================== */
float getMaxVar() { return maxVar; };
float getMinVar() { return minVar; };
