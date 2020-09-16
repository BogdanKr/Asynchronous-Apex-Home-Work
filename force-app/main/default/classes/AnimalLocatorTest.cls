/**
 * Created by Bogdan on 16.09.2020.
 */
@IsTest
public with sharing class AnimalLocatorTest {
    @IsTest
    static void testAnimal(){
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());

        String response = AnimalLocator.getAnimalNameById(2);
        String expectedValue = 'bear';
        System.assertEquals(expectedValue, response);
    }

}