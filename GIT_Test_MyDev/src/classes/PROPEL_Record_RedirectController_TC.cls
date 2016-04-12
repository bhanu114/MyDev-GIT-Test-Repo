/*========================================================================================================================+
 |  HISTORY                                                                  
 |                                                                           
 |  DATE            DEVELOPER       WR/Req     DESCRIPTION                               
 |  ====            =========       ======     ===========             
 |  05.May.2015    Bhanuprakash     PROPEL     Created to test Record_RedirectController class
 +=========================================================================================================================*/
 
@isTest
public class PROPEL_Record_RedirectController_TC{
    public Static List<Account> acctLst = new List<Account>();
    public Static List<Opportunity> lstOpp= new List<Opportunity>();
 
    PROPEL_Record_RedirectController_TC() {}
    
     //Method for Creation Of Test Data    
     @testSetup public static void setupData(){
        
       //Create Account
       acctLst = new List<Account>();
       acctLst.add(new Account(Name='Acme'));       
       insert acctLst ;
       
       // Create list of Opptys
        for(Integer k=0;k<2;k++){
           Opportunity opp_Obj = new Opportunity();
           opp_Obj.AccountId =acctLst[0].id;
           opp_Obj.Name = 'TEST'+ k;
           opp_Obj.StageName = 'Test';
           opp_Obj.StageName = 'Pipeline';
           opp_Obj.CloseDate = Date.today()+10;
          
           lstOpp.add(opp_Obj);
         }//end - for
         
        insert lstOpp;
     }
     //Test method to test 'Record_RedirectController.redirect()' method
    @isTest static void  testRedirect() {
    Test.starttest();
        
        //Prepare request context
        Test.setCurrentPageReference(new PageReference('Page.Record_Redirect'));
        System.currentPageReference().getParameters().put('object', 'Opportunity');
        System.currentPageReference().getParameters().put('field', 'Name');
        
        List<Opportunity> oppRequest = [SELECT Name FROM Opportunity LIMIT 10];
        System.assertNotEquals(oppRequest, null);
        System.debug('*** queried oppty = '+ oppRequest);
        
        System.currentPageReference().getParameters().put('value', oppRequest[0].name);
        //call actual class and method
        PROPEL_Record_RedirectController record = new PROPEL_Record_RedirectController();
        //Test : positive scenario
        record.redirect();
        
        //Test : Negetive : if parameters are empty
        System.currentPageReference().getParameters().put('object', '');
        System.currentPageReference().getParameters().put('field', '');
        System.currentPageReference().getParameters().put('value', '');
        record.redirect();
        System.assertNotEquals(record,null);
        
        //Check is page having any error messages to show
        List<Apexpages.Message> msgs = ApexPages.getMessages();
        System.assertEquals((msgs != null)? msgs.size() : 0, 3);
        system.assert(msgs.size() > 0);//Assert the Page Message was Properly 
        
        //Test : Negetive : if DML exception
        System.currentPageReference().getParameters().put('object', 'Opportunity');
        System.currentPageReference().getParameters().put('field', 'NoField');
        System.currentPageReference().getParameters().put('value', 'Test');
        record.redirect();
        
        //Test : Negetive : if more than 1 record found
        //Update 2nd opty to fetch 2 oppty records
        Opportunity updateOppty = oppRequest[1];
        updateOppty.Name = 'TEST0';
        update updateOppty;
        
        System.currentPageReference().getParameters().put('object', 'Opportunity');
        System.currentPageReference().getParameters().put('field', 'Name');
        System.currentPageReference().getParameters().put('value', 'TEST0');
        record.redirect();
        
        //Test : Negetive : if more 0 record found
        delete oppRequest;
        System.currentPageReference().getParameters().put('object', 'Case');
        System.currentPageReference().getParameters().put('field', 'Name');
        System.currentPageReference().getParameters().put('value', 'NoValue');
        record.redirect();
        List<Opportunity> finalOpptys = [SELECT ID FROM Opportunity LIMIT 10];
        System.debug('**** finalOpptys = ' +finalOpptys);
        System.assertNotEquals(finalOpptys, null);
        System.assertNotEquals(record,null);
        
    Test.stoptest();
    }
}