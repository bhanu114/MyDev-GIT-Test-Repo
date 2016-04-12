/*===========================================================================+
 |  HISTORY                                                                  
 |                                                                           
 |  DATE       DEVELOPER        WR       DESCRIPTION                               
 |  ====       =========        ==       =========== 
 |  30-APR-2015   PROPEL                 New controller
 |  06-MAY-2015   Bhanuprakash  PROPEL   Optimized class by handling exceptions and implementing coding standards
  +===========================================================================*/

public with sharing class PROPEL_Record_RedirectController{

    public PROPEL_Record_RedirectController(){}

    public PageReference redirect() {
        Boolean isError = false;
         
        String objectName = ApexPages.currentPage().getParameters().get('object');
        String fieldName = ApexPages.currentPage().getParameters().get('field');
       String fieldValue = ApexPages.currentPage().getParameters().get('value');
       
       
       //Handling exception on parameters passed
       if( objectName == null || objectName == ''){
         String message = Label.PROPEL_URL_Object_null;
          ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,message));
          isError = true;
       }
       if( fieldName == null || fieldName == ''){
         String message = Label.PROPEL_URL_Field_null;
          ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,message));
          isError = true;
       }
       if( fieldValue == null || fieldValue == ''){
         String message = Label.PROPEL_URL_Value_null;
          ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,message));
          isError = true;
       }
       //return null if any parameter is not passed
       if(isError)
        return null;
        
        //Prepare dynamic SOQL to fetch object ID
       String query = 'select ID from ' + objectName + ' where ' + fieldName + ' = \'' + fieldValue +'\'';

       List<SObject> results = new List<SObject>();
        try{
            results = Database.query(query);
        }catch(Exception e){
            ApexPages.addmessages(e);
            return null;
        }
            
       if(results == null || results.isEmpty()){
          String message = Label.PROPEL_No_Data;
          ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,message));
       } else if (results.size() > 1) { 
          String message = Label.PROPEL_more_records_found;
          ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,message));
       } else if (results.size() == 1) {
          system.debug('Opportunity ID = ' + results[0].id);
          PageReference redirectPage = new PageReference('/'+results[0].id);
          redirectPage.setredirect(true);
          return redirectPage;
       }
       return null;
    }
}