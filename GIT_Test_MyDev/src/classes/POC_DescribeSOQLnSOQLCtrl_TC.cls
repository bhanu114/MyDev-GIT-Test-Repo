/*
*   To test POC_DescribeSOQLnSOQLCtrl class
*/
@isTest
public class POC_DescribeSOQLnSOQLCtrl_TC {
    @TestSetup private static void setupTestData(){
        List<Account> lstAccs = AccountTestDataHelper.createAccounts();
        insert lstAccs;
    }

 @isTest private static void testPerformSOSLSearch(){
    POC_DescribeSOQLnSOQLCtrl sl = new POC_DescribeSOQLnSOQLCtrl();
    List<POC_DescribeSOQLnSOQLCtrl.ObjWrapper> lstWrap = new List<POC_DescribeSOQLnSOQLCtrl.ObjWrapper>();
    POC_DescribeSOQLnSOQLCtrl.ObjWrapper ow = new POC_DescribeSOQLnSOQLCtrl.ObjWrapper(0);
    ow.objName = 'Account';
    
    POC_DescribeSOQLnSOQLCtrl.ObjWrapper ow2 = new POC_DescribeSOQLnSOQLCtrl.ObjWrapper(0);
    ow2.objName = 'Opportunity';
    
    lstWrap.add(ow);
    lstWrap.add(ow2);
    POC_DescribeSOQLnSOQLCtrl.lstWraps = lstWrap;
    ApexPages.currentPage().getParameters().put('findText', 'test');
    
    Test.startTest();
    sl.findText =ApexPages.currentPage().getParameters().get('findText');
    sl.performSOSLSearch();
    Test.stopTest();
 }
}