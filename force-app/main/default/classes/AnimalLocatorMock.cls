/**
 * Created by Bogdan on 16.09.2020.
 */

public with sharing class AnimalLocatorMock implements HttpCalloutMock{


    public HttpResponse respond(HttpRequest param1) {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"animal":{"id":2,"name":"bear","eats":"berries, campers, adam seligman","says":"yum yum"}}');
        response.setStatusCode(200);
        return response;
    }
}