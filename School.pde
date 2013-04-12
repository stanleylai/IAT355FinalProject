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
private int achievementSurvey;

// location data
private Location location;

// marker data
SimplePointMarker marker;

// HashMap
HashMap hm;


/* ==================================================
 * Constructor Method
 * ================================================== */
School(String name, int number, float lat, float lon) {
  hm = new HashMap();
  setSchoolName(name);
  setSchoolNumber(number);
  setLocation(lat, lon);
  marker = new SimplePointMarker(location);
}



/* ==================================================
 * Rendering Methods
 * ================================================== */
public void addMarkerTo(UnfoldingMap map) {
  hm.put("NAME", getSchoolName());
  hm.put("NUMBER", getSchoolNumber());
  hm.put("LOCATION", getLocation());
  hm.put("ACHIEVEMENT", getAchievementValue());
  
  marker.setProperties(hm);
  
  float colorVar = map(getAchievementValue(), getMinVar(), getMaxVar(), 0, 255);
  marker.setColor(int(colorVar));
  
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

// Achievement Survey
public void setAchievementValue(int i) { achievementSurvey = i; };
public int getAchievementValue() { return achievementSurvey; };

// SimplePointMarker
public SimplePointMarker getPointMarker() { return marker; };



/* ==================================================
 * Closing Tag for End of Class
 * ================================================== */
}
