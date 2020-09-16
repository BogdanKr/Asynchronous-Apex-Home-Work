/**
 * Created by Bogdan on 16.09.2020.
 */

@IsTest
public with sharing class ParkServiceMock implements WebServiceMock {

    public void doInvoke(Object param1, Object param2, Map<String, Object> response,
            String param4, String param5, String param6, String param7, String param8, String param9) {

        // start - specify the response you want to send
        ParkService.byCountryResponse response_x =
                new ParkService.byCountryResponse();
        response_x.return_x = new String[]{'Hamburg Wadden Sea National Park, ' +
                'Hainich National Park, Bavarian Forest National Park'};
        // end
        response.put('response_x', response_x);
    }
}