/**
 * Created by Bogdan on 16.09.2020.
 */
@IsTest
public with sharing class ParkLocatorTest {
    @IsTest
    static void testGetParksByCountry() {
        Test.setMock(WebServiceMock.class, new ParkServiceMock());

        String[] expectedResult = new String[]{
                'Hamburg Wadden Sea National Park, ' +
                        'Hainich National Park, Bavarian Forest National Park'
        };
        String[] result = ParkLocator.country('Germany');

        System.assertEquals(expectedResult, result);
    }

}