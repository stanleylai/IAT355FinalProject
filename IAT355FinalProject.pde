/* ==================================================
 * IAT355 Spring 2013 - Final Project
 * April 4, 2013
 *
 * Stanley Lai Zhen-Yu (zlai)
 * Ooi Yee Loong
 * ================================================== */

/* ==================================================
 * Imports
 * ================================================== */
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

// Array of School objects
School[] schools;


/* ==================================================
 * Setup Method
 * ================================================== */
void setup() {
  // Load and crunch CSV file
  schoolInfoDataFile = loadStrings("BCSchoolInfo_10012012.csv");
  processData(schoolInfoDataFile);

  // Init Unfolding Map
  size(1280, 700, GLConstants.GLGRAPHICS);
  map = new UnfoldingMap(this, new OpenStreetMap.CloudmadeProvider("dcd2157d99f04bbf97922278fd9584b8", 998));
  map.zoomAndPanTo(new Location(49.21, -122.9), 11); // Position map at Vancouver
  MapUtils.createDefaultEventDispatcher(this, map); // Enable basic user interactions
  map.setTweening(true); // Animate all map movements
  
  // Draw school markers
  addSchoolMarkers();
}



/* ==================================================
 * Draw Method
 * ================================================== */
void draw() {
  // Redraw Unfolding Map
  map.draw();
  
  // Display co-ordinates at mouse
  Location pointerLoc = map.getLocation(mouseX, mouseY);
  fill(255);
  text(pointerLoc.getLat() + ", " + pointerLoc.getLon(), mouseX, mouseY);
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
 
 
 
/* ==================================================
 * Data Processing Methods
 * ================================================== */
void processData(String[] file) {
  schools = new School[file.length-1];
  
  String[] columnNames = split(file[0], ",");
  int nameColumn = searchForColumnName("SCHOOL_NAME", columnNames);
  int schoolNumberColumn = searchForColumnName("SCHOOL_NUMBER", columnNames);
  int latColumn = searchForColumnName("SCHOOL_LATITUDE", columnNames);
  int lonColumn = searchForColumnName("SCHOOL_LONGITUDE", columnNames);
  
  println(nameColumn);
  println(schoolNumberColumn);
  println(latColumn);
  println(lonColumn);
  
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
