global class ScheduledBatchSearchAndReplace implements Schedulable {
   global void execute(SchedulableContext sc) {
       String query = 'Select Id, Name From Account';
      BatchSearchAndReplace b = new BatchSearchAndReplace(query); 
      database.executebatch(b);
   }
}