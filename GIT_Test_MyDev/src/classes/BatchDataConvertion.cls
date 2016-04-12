/*
*   Class to perform Batch Data convertion
*/
global class BatchDataConvertion implements Database.Batchable<sObject> {
    private final String objectName = null;
    private final String field = null;
    private final String oldValue = null;
    private final String value = null;
    /*
    *   Constructor
    */
    global BatchDataConvertion(String objectName, String field, String oldValue, String value){
      this.objectName = objectName; this.field = field; this.oldValue = oldValue; this.value = value;
   }
    /*
    *   Method : start
    */
    global Database.QueryLocator start(Database.BatchableContext BC){
        String query = 'SELECT ' + field + ' FROM ' + objectName + ' WHERE ' + field + ' LIKE :' + oldValue ;
        System.debug('***** BatchDataConvertion, start,  query = ' + query);
      //return Database.getQueryLocator('SELECT  ' + field + ' FROM  ' + objectName + ' WHERE  ' + field + ' LIKE :oldValue');
      return Database.getQueryLocator('SELECT name from Account'); //+ ' WHERE name LIKE :' + oldValue + '\'');
   }
    /*
    *   Method : execute
    */
    global void execute(Database.BatchableContext BC, List<sObject> scope){
     for(sobject s : scope){
         System.debug('**** BatchDataConvertion, execute, got result, filed = ' + field + ' : value = '  + value);
     s.put(field,value);
     }
     update scope;
    }
   /*
    *   Method : finish
    */
   global void finish(Database.BatchableContext BC){ System.debug('*** in finish');
   // Get the ID of the AsyncApexJob representing this batch job
   // from Database.BatchableContext.
   // Query the AsyncApexJob object to retrieve the current job's information.
   AsyncApexJob a = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed,
      TotalJobItems, CreatedBy.Email
      FROM AsyncApexJob WHERE Id =
      :BC.getJobId()];
      System.debug('**** job created email = ' + a.CreatedBy.Email);
   // Send an email to the Apex job's submitter notifying of job completion.
   Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
   String[] toAddresses = new String[] {a.CreatedBy.Email,'bhanuprakash.jangam@accenture.com'};
   mail.setToAddresses(toAddresses);
   mail.setSubject('Apex Sharing Recalculation ' + a.Status);
   mail.setPlainTextBody
   ('The batch Apex job processed ' + a.TotalJobItems +
   ' batches with '+ a.NumberOfErrors + ' failures.');
   Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
}

}