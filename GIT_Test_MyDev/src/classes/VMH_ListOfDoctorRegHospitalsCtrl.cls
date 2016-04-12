/*
*   Controller for VMH_ListOfDoctorRegHospitalsPage
*/
public class VMH_ListOfDoctorRegHospitalsCtrl {
    public Map<ID,Hospitals_and_Doctor__c> hADMap {get;set;}
    public List<HospitalAndDocterWrapper> hadwList {set;get;}
    public List<Hospital__c> hList {set;get;}
    //public List<Hospital__c> newHospital = null;
    private Set<Id> hIdSet = new Set<ID>();
    public Doctor__c currentDoctor = null;
    
    //Defalt Constructor
    public VMH_ListOfDoctorRegHospitalsCtrl(){}
    
    /*
    * Parametarized Constrocter 
    * Step 1 : get All HAD's related to this Doctor
    * 2. Get Hospital Id from HSD's
    * 3. Get all H's from HAD's
    */
    public VMH_ListOfDoctorRegHospitalsCtrl(ApexPages.StandardController standard) {
        
        currentDoctor =(Doctor__c) standard.getRecord();
        System.debug('**** Docter ID = ' + currentDoctor);
        //get All HAD's related to this Doctor
        hADMap = new Map<ID,Hospitals_and_Doctor__c>([SELECT Hospital__c FROM Hospitals_and_Doctor__c WHERE Doctor__c =: currentDoctor.Id ]);
        System.debug('***** in Construcot, after SOQL, hADList sile = ' + hADMap.size());
        //hADMap = new Map<ID,Hospitals_and_Doctor__c>([SELECT Name FROM Hospital__c WHERE Doctor__c =: currentDoctor.Id ]);
        //Get Hospital Id from HSD's
        for(Hospitals_and_Doctor__c had : hADMap.values()){
            hIdSet.add(had.Hospital__c);
            
        }
        System.debug('*****hIdSet = ' + hIdSet);
        //Get all H's from HAD's 
        hList = [Select Id, name, Country__c, State__c From Hospital__c where ID IN :hIdSet];
        System.debug('***** in Construcot, after SOQL, hList sile = ' + hList.size());
        HospitalAndDocterWrapper hadw = null;
        hadwList = new List<HospitalAndDocterWrapper>();
        for(Hospital__c h : hList){
            //hadw = new HospitalAndDocterWrapper(h.Id, new Doctor__c());
            //hadwList.add(hadw);
        }
    }
    
    public void addWorkingHospital(){
        
        
    }
    
    /*public List<Hospitals_and_Doctor__c>  getAllWorkingHospitols(){
        //Id docId = apexpages.currentpage().getparameters().get('id');
        
        return hADList;
    }*/
    
    class HospitalAndDocterWrapper {
        public HospitalAndDocterWrapper(Hospital__c h, Doctor__c d){
            //had = new Hospitals_and_Doctor__c(Hospital__c = h, Doctor__c = d);
            //had.Doctor__c = d;
        }
        public Hospitals_and_Doctor__c had {set;get;}
        public Boolean isUpdatable = true;
        public Boolean flag = true;
    }
}