global class BatchSearchAndReplace implements Database.Batchable<sObject>{

   global final String Query;

   global BatchSearchAndReplace(String q){

      Query=q; 
   }

   global Database.QueryLocator start(Database.BatchableContext BC){
      return Database.getQueryLocator(query);
   }

   global void execute(Database.BatchableContext BC, List<sObject> scope){
     for(sobject s : scope){
     s.put('Name','Batch Update'); 
     }
     update scope;
    }

   global void finish(Database.BatchableContext BC){
   }
}