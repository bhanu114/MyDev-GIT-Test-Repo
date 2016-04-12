@isTest
private class TestFactoryTest {
    private static testMethod void testDemo() {
        // The TestFactory will pre-fill all the fields we typically need
        Account a = (Account)TestFactory.createSObject(new Account());
        System.debug('**** TestFactory.createSObject(new Account() = ' + a);
        insert a;
        
        // You can also set values to be used. Any values set in the constructor will override the defaults
        Opportunity o = (Opportunity)TestFactory.createSObject(new Opportunity(AccountId = a.Id));
        System.debug('**** TestFactory.createSObject(new Opportunity(AccountId = a.Id) = ' + o);
        
        // You can also specify a specific set of overrides for different scenarios
        Account a1 = (Account)TestFactory.createSObject(new Account(), 'TestFactory.AccountDefaults');
        System.debug('*** TestFactory.createSObject(new Account(), TestFactory.AccountDefaults)  = ' + a1);
        
        // Finally, get a bunch of records for testing bulk
        Account[] aList = (Account[])TestFactory.createSObjectList(new Account(), 200);
        System.debug('*** aList = ' + aList);
        
        // You can optionally insert records as created like this:
        // Note the final parameter of true.
        Account a2 = (Account) TestFactory.createSObject(new Account(), true);
        System.debug('**** a2 = ' + a2);
        
        Contact c = (Contact) TestFactory.createSObject(new Contact(AccountID = a.Id), true);
        System.debug('***** c = ' + c);
    }
}