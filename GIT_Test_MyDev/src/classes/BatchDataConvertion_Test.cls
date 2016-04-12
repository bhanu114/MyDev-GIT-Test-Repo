@isTest
public class BatchDataConvertion_Test {
    @testSetup static void setup() {
        // Create common test accounts
        List<Account> testAccts = new List<Account>();
        for(Integer i=0;i<2;i++) {
            testAccts.add(new Account(Name = 'TestAcct'+i));
        }
        insert testAccts;       
    }
    
    @isTest static void testBatchDataConvertion() {
        //BatchDataConvertion(objectName, field, oldValue)
        Test.startTest();
        //BatchDataConvertion.value = 'Batch update name';
        BatchDataConvertion bdc = new BatchDataConvertion('Account','name','TestAcct','Batch update name');
        Database.executeBatch(bdc);
        List<Account> accList = [SELECT name FROM Account Limit 10];
        for(Account act : accList){
            System.debug('***** Test, act name = ' + act.name);
        }
        Test.stopTest();
    }
    
    
}