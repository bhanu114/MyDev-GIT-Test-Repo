/*
 HISTORY                                                                  
 |                                                                           
 |   DATE            DEVELOPER        WR/Req         DESCRIPTION                               
 |   ====            =========        ======         =========== 
 |  23-JAN-2016      BhanuPrakash   FieldTypeCount  Test class for FieldTypeCountHelper class   
*/
@isTest
private class FieldTypeCountHelperTest {
    /*
    * <Discritption of class level variable created to use>
    */
    //private <Variable Type> <variableName> = <variable assignment>//assighn at least 'null' value
    
    
    /*
    *  < Test setup method implementation[this test method used to create test records one time and use across the class by just querying them in any method]>
    */
    
    private static testMethod void testPerform(){
        Test.startTest();
        //List<FieldTypeCount.FieldTypeWrapper> ftwlst = 
        //FieldTypeCountHelper.perform();
        Test.stopTest();
        //for(FieldTypeWrapper ftw : ftwlst){
            System.debug('**** Test : ftw = ' + FieldTypeCountHelper.perform());
        //}
        //System.assertNotEquals(ftwlst,null);
    }
    
}