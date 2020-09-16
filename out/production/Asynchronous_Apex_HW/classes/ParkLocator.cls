/**
 * Created by Bogdan on 16.09.2020.
 */

public with sharing class ParkLocator {
    public static String [] country(String country) {
        ParkService.ParksImplPort parksImplPort = new ParkService.ParksImplPort();
        return parksImplPort.byCountry(country);
    }
}