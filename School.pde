/* ==================================================
 * IAT355 Spring 2013 - Final Project
 * April 4, 2013
 *
 * Stanley Lai Zhen-Yu (zlai)
 * Ooi Yee Loong
 * ================================================== */

/* ==================================================
 * School Class
 * ================================================== */

class School {

/* ==================================================
 * Init
 * ================================================== */
// basic info
private String name;
private int schoolNumber;

// location data
private Location location;

// marker data
SimplePointMarker marker;


/* ==================================================
 * Constructor Method
 * ================================================== */
School(String name, int number, float lat, float lon) {
  setSchoolName(name);
  setSchoolNumber(number);
  setLocation(lat, lon);
  marker = new SimplePointMarker(location);
}



/* ==================================================
 * Rendering Methods
 * ================================================== */
public void addMarkerTo(UnfoldingMap map) {
  map.addMarkers(marker);
}
 
 
 
/* ==================================================
 * Getter & Setter Methods
 * ================================================== */
// Name
public void setSchoolName(String s) { name = s; }
public String getSchoolName() { return name; }

// School Number
public void setSchoolNumber(int n) { schoolNumber = n; }
public int getSchoolNumber() { return schoolNumber; }

// Location
public void setLocation(float lat, float lon) { location = new Location(lat, lon); }
public Location getLocation() { return location; };
public float getLocationLon() { return location.getLon(); };
public float getLocationLat() { return location.getLat(); };

// SimplePointMarker
public SimplePointMarker getPointMarker() { return marker; };



/* ==================================================
 * Closing Tag for End of Class
 * ================================================== */
}
