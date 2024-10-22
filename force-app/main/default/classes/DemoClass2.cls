// 10 con rec
public with sharing class DemoClass2 {
    @AuraEnabled(cacheable=true)
    public static List<Contact> call() {
        return [SELECT LastName, FirstName, Email, Phone FROM Contact ORDER BY createdDate LIMIT 10];
    }
}