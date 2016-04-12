/*

*/   

@isTest
private class TestSmartFactory_Test {
    static {
        TestSmartFactory.fillAllFields = true; // increase test coverage without creating custom objects
    }  
    static testMethod void createSObjectListTest(){
        List<User> userList = (List<User>) TestSmartFactory.createSObjectList('User',true, 10);
        System.assertEquals(10,userList.size());
        System.debug('*** userList.size() = ' + userList.size());
        
        List<Account> accList = (List<Account>) TestSmartFactory.createSObjectList('Account',true, 10);
        System.assertEquals(10,accList.size());
        System.debug('*** accList.size() = ' + accList.size());
        
        List<Opportunity> oppList = (List<Opportunity>) TestSmartFactory.createSObjectList('Opportunity',true, 10);
        System.assertEquals(10,oppList.size());
        System.debug('*** oppList.size() = ' + oppList.size());
    }
    /*static testMethod void createRandomObjects(){
        Map<String, Schema.SObjectType> globalDescribe = Schema.getGlobalDescribe();
        //TestSmartFactory.createSObject('bhanuspace__income_type__c');
        //System.debug('**** TestSmartFactory_Test, bhanuspace__income_type__c, Created : ' + TestSmartFactory.createSObject('bhanuspace__income_type__c'));
        //for(Integer i=0; i < 10; i++){
        List<SObject> soList = new List<SObject>();
        SObject s = null;
        
        for(String objName : globalDescribe.keySet()){
            //TestSmartFactory.createSObject(objName);
            if(objName.contains('__c')){
                s = TestSmartFactory.createSObject(objName);
                System.debug('**** TestSmartFactory_Test, createRandomObjects, Created : '  + s);
                soList.add(s);
            }
        }try{
            System.debug('*** soList size = ' + soList.size());
            Database.insert(soList);
            System.debug('**** Test class, Insertion success');
        }catch(Exception e){
            System.debug('*** Exception : ' + e);
        }
    }
    static testMethod void createsSingleObjectWithSingleRequiredStringField() {
        Account account = (Account)TestSmartFactory.createSObject('Account');
        insert account;
        System.debug('**** createsSingleObjectWithSingleRequiredStringField, account = ' + account);
        System.assert(account.Id != null);
        System.assert(account.Name != null);
    }
    
    static testMethod void createsObjectWithCascadeSetsLookupField() {
        Contact contact = (Contact)TestSmartFactory.createSObject('Contact', true);
        insert contact;
        System.debug('**** createsObjectWithCascadeSetsLookupField, contact = ' + contact);
        System.assert(contact.Id != null);
        System.assert(contact.AccountId != null);
    }
    
    static testMethod void createsObjectWithoutCascadeDoesNotSetLookupField() {
        Contact contact = (Contact)TestSmartFactory.createSObject('Contact', false);
        insert contact;
        System.debug('**** createsObjectWithoutCascadeDoesNotSetLookupField, contact = ' + contact);
        System.assert(contact.AccountId == null);
    }
    
    static testMethod void createObjectWithUnsupportedTypeThrowsException() {
        try {
            TestSmartFactory.createSObject('Unsupported');
            System.assert(false);
        } catch (UnsupportedObjectTypeException ex) {
        System.debug('**** createObjectWithUnsupportedTypeThrowsException, in catch ');
            System.assert(true);
        }
    }*/
    public with sharing class UnsupportedObjectTypeException extends Exception {}
}