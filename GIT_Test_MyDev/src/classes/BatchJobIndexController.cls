public class BatchJobIndexController {
    
    public set<string> jobTypeSet {get;set;}
    public set<string> apexClassSet {get;set;}
    public set<string> statusSet {get;set;}
    public set<string> methodNameSet {get;set;}
    public string selectedJobType {get;set;}
    public string selectedapexClass {get;set;}
    public string selectedstatus {get;set;}
    public string selectedmethodName {get;set;}
    public set<string> apexClassSet_temp;
    public Map<string,string> apexClassMap = new Map<string,string>();
    public List<AsyncApexJob> jobsToDisplay {get;set;}
    public BatchJobIndexController(){
        
        jobTypeSet = new set<string>();
        apexClassSet = new set<string>();
        statusSet = new set<string>();
        methodNameSet = new set<string>();
        apexClassSet_temp = new set<string>(); 
        apexClassMap = new Map<string,string>();
        jobsToDisplay = new List<AsyncApexJob>();
        List<AggregateResult > asyncJobs = [SELECT count(Id), JobType, ApexClassId, Status, MethodName FROM AsyncApexJob GROUP BY JobType, ApexClassId, Status, MethodName limit 100];
        System.debug('asyncJobs::::'+asyncJobs);
       for(AggregateResult ag : asyncJobs){
            jobTypeSet.add((string)ag.get('JobType'));
            apexClassSet_temp.add((string)ag.get('ApexClassId'));
            statusSet.add((string)ag.get('Status'));
            methodNameSet.add((string)ag.get('MethodName'));
        }
        if(apexClassSet_temp.size() >0){
            for(ApexClass x : [SELECT Id, Name FROM ApexClass where ID IN :apexClassSet_temp]){
                apexClassMap.put(x.name,x.id);
            }
            apexClassSet = apexClassMap.keySet();
        }
    }
    public List<SelectOption> getjobTypeOptions() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('','All'));
        for(string x : jobTypeSet){
            if(string.isNotBlank(x))
            options.add(new SelectOption(x,x));
        }
        return options;
    }  
    public List<SelectOption> getapexClassOptions() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('','All'));
        for(string x : apexClassMap.keySet()){
            if(string.isNotBlank(x))
            options.add(new SelectOption(x,x));
        }
        return options;
    }      
    public List<SelectOption> getStatusOptions() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('','All'));
        for(string x : statusSet){
            if(string.isNotBlank(x))
            options.add(new SelectOption(x,x));
        }
        return options;
    } 
    public List<SelectOption> getmethodNameOptions() {
        /*List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('','All'));
        for(string x : methodNameSet){
            if(string.isNotBlank(x))
            options.add(new SelectOption(x,x));
        }
        return options;
        */
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('','All'));
        if(String.isNotBlank(selectedapexClass)){
            System.debug('*** in getMethods, selected class name = ' + selectedapexClass);
            ID selectedClassId = apexClassMap.get(selectedapexClass);
            System.debug('*** in getMethods, selected class ID = ' + selectedClassId);
            List<AsyncApexJob > asyncJobs = [SELECT MethodName FROM AsyncApexJob where ApexClassId =: selectedClassId  limit 100];
            System.debug('*** in getMethods, asyncJobs size = ' + asyncJobs.size());
            for(AsyncApexJob ar : asyncJobs){
                options.add(new SelectOption(ar.MethodName,ar.MethodName));
            }
        }
        return options;
    }      
    public pagereference doSearch(){
        string q = 'SELECT Id, JobType, CreatedById,CreatedBy.name, CreatedDate, ApexClassId,ApexClass.name, Status, JobItemsProcessed, TotalJobItems, NumberOfErrors, CompletedDate, MethodName, ExtendedStatus, ParentJobId, LastProcessedOffset, LastProcessed FROM AsyncApexJob';
        if(string.isNotBlank(selectedJobType) || string.isNotBlank(selectedapexClass) || string.isNotBlank(selectedstatus) || string.isNotBlank(selectedmethodName)){
            q = q + ' where ';
            if(string.isNotBlank(selectedJobType)){
                 q = q + 'JobType = :selectedJobType ';
            }
            if(string.isNotBlank(selectedapexClass)){
                 q = addAND(q);
                 q = q + 'ApexClass.name = :selectedapexClass ';
            }
        
            if(string.isNotBlank(selectedstatus)){
                q = addAND(q);
                 q = q + 'Status = :selectedstatus ';
            }
            if(string.isNotBlank(selectedmethodName)){
                q = addAND(q);
                 q = q + 'MethodName = :selectedmethodName ';
            }            
        
        }
        q = q.trim();
        system.debug('The Running Query::'+q);
        jobsToDisplay = Database.query(q);
        //jobsToDisplay = [SELECT Id, JobType, CreatedById,CreatedBy.name, CreatedDate, ApexClassId,ApexClass.name, Status, JobItemsProcessed, TotalJobItems, NumberOfErrors, CompletedDate, MethodName, ExtendedStatus, ParentJobId, LastProcessedOffset, LastProcessed FROM AsyncApexJob];
        return null;
    }
    private String addAND(String query){
        if(!query.endsWith(' where ')){
            query+= ' AND ';
            return query;
        }
        return query;
    }
}