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

// grad rate
private int[] gradRateValue;

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
  
  gradRateValue = new int[16];
}



/* ==================================================
 * Rendering Methods
 * ================================================== */
public void addMarkerTo(UnfoldingMap map, int value) {
  hm.put("NAME", getSchoolName());
  hm.put("NUMBER", getSchoolNumber());
  hm.put("LOCATION", getLocation());
  hm.put("VALUE", value);
  
  marker.setProperties(hm);
  
  float colorVar = map(value, getMinVar(), getMaxVar(), 0, 255);
  marker.setColor(color(0, 0, colorVar));
  marker.setStrokeWeight(0);
  
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

// Grad Rate
public void setGradRate(String schoolYear, int value) {
  if (schoolYear.equals("1996/1997")) { gradRateValue[0] = value; }
  else if (schoolYear.equals("1997/1998")) { gradRateValue[1] = value; }
  else if (schoolYear.equals("1998/1999")) { gradRateValue[2] = value; }
  else if (schoolYear.equals("1999/2000")) { gradRateValue[3] = value; }
  else if (schoolYear.equals("2000/2001")) { gradRateValue[4] = value; }
  else if (schoolYear.equals("2001/2002")) { gradRateValue[5] = value; }
  else if (schoolYear.equals("2002/2003")) { gradRateValue[6] = value; }
  else if (schoolYear.equals("2003/2004")) { gradRateValue[7] = value; }
  else if (schoolYear.equals("2004/2005")) { gradRateValue[8] = value; }
  else if (schoolYear.equals("2005/2006")) { gradRateValue[9] = value; }
  else if (schoolYear.equals("2006/2007")) { gradRateValue[10] = value; }
  else if (schoolYear.equals("2007/2008")) { gradRateValue[11] = value; }
  else if (schoolYear.equals("2008/2009")) { gradRateValue[12] = value; }
  else if (schoolYear.equals("2009/2010")) { gradRateValue[13] = value; }
  else if (schoolYear.equals("2010/2011")) { gradRateValue[14] = value; }
  else if (schoolYear.equals("2011/2012")) { gradRateValue[15] = value; }
};
public int getGradRate(String schoolYear) {
  int r = -1;
  
  if (schoolYear.equals("1996/1997")) { r = gradRateValue[0]; }
  else if (schoolYear.equals("1997/1998")) { r = gradRateValue[1]; }
  else if (schoolYear.equals("1998/1999")) { r = gradRateValue[2]; }
  else if (schoolYear.equals("1999/2000")) { r = gradRateValue[3]; }
  else if (schoolYear.equals("2000/2001")) { r = gradRateValue[4]; }
  else if (schoolYear.equals("2001/2002")) { r = gradRateValue[5]; }
  else if (schoolYear.equals("2002/2003")) { r = gradRateValue[6]; }
  else if (schoolYear.equals("2003/2004")) { r = gradRateValue[7]; }
  else if (schoolYear.equals("2004/2005")) { r = gradRateValue[8]; }
  else if (schoolYear.equals("2005/2006")) { r = gradRateValue[9]; }
  else if (schoolYear.equals("2006/2007")) { r = gradRateValue[10]; }
  else if (schoolYear.equals("2007/2008")) { r = gradRateValue[11]; }
  else if (schoolYear.equals("2008/2009")) { r = gradRateValue[12]; }
  else if (schoolYear.equals("2009/2010")) { r = gradRateValue[13]; }
  else if (schoolYear.equals("2010/2011")) { r = gradRateValue[14]; }
  else if (schoolYear.equals("2011/2012")) { r = gradRateValue[15]; }
  
  return r;
};
public int getGradRate(int schoolYearIndex) {
  int r = gradRateValue[schoolYearIndex];
  if (r >= 0) {
    return r;
  } else {
    return -1;
  }
}

// Achievement Survey
public void setAchievementValue(int i) { achievementSurvey = i; };
public int getAchievementValue() { return achievementSurvey; };

// SimplePointMarker
public SimplePointMarker getPointMarker() { return marker; };



/* ==================================================
 * Closing Tag for End of Class
 * ================================================== */
}
