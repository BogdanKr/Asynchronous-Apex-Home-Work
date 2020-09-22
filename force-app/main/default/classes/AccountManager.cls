/**
 * Created by Bogdan on 16.09.2020.
 */

@RestResource(UrlMapping='/Accounts/*')
global with sharing class AccountManager {
    @HttpGet
    global static Account getAccount() {
        RestRequest request = RestContext.request;
//        String accountId = request.requestURI.substringBetween('Accounts/', '/Contacts');
        String accountId = request.requestURI.substring(
                request.requestURI.lastIndexOf('/') + 1);
        Account result = [
                SELECT Name, Owner.Name, (SELECT Name FROM Contacts)
                FROM Account
                WHERE Id = :accountId
        ];

        return result;
    }

    @HttpPost
    global static Id createAccount() {
        RestRequest request = RestContext.request;
        Map<String, Object> params = (Map<String, Object>) JSON.deserializeUntyped(request.requestBody.toString());
        // Iterate through each parameter field and value
        Account thisAccount = new Account();
        for (String fieldName : params.keySet()) {
            thisAccount.put(fieldName, params.get(fieldName));
        }
        insert thisAccount;
        return thisAccount.Id;
    }

    @HttpDelete
    global static void deleteAccount() {
        RestRequest request = RestContext.request;
        String caseId = request.requestURI.substring(
                request.requestURI.lastIndexOf('/') + 1);
        Account thisAccount = [SELECT Id FROM Account WHERE Id = :caseId];
        delete thisAccount;
    }

    @HttpPut
    global static Id upsertAccount(String id, String name, String phone, String website) {
        Account thisAccount = new Account(
                Id = id,
                Name = name,
                Phone = phone,
                Website = website);
        upsert thisAccount;
        return thisAccount.Id;
    }
    @HttpPatch
    global static Id updateAccountFields() {
        RestRequest request = RestContext.request;
        String caseId = request.requestURI.substring(
                request.requestURI.lastIndexOf('/') + 1);
        Account thisAccount = [SELECT Id FROM Account WHERE Id = :caseId];
        // Deserialize the JSON string into name-value pairs
        Map<String, Object> params = (Map<String, Object>) JSON.deserializeUntyped(request.requestBody.toString());
        // Iterate through each parameter field and value
        for (String fieldName : params.keySet()) {
            thisAccount.put(fieldName, params.get(fieldName));
        }
        update thisAccount;
        return thisAccount.Id;
    }
}