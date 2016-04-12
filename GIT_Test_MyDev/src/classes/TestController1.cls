Public class TestController1{
    public List<TestWrapper> twList{set;get;}
    public Integer twSize = 0;
    public static List<String> monthHeader{set;get;}
    public static Integer ZERO{set;get;}
    public string textField{
    Get{
    If(textField == null) return 'default';
                   Return textField ;                    
      }
        Set;
    }
    
    
    public TestController1(){
    }
    static Map<Integer,String> monthsMap = new Map<Integer,String> ();
    static{
        ZERO = 0;
        monthHeader = new List<String>();
        monthsMap.put(1,'Jan');
        monthsMap.put(2,'Feb');
        monthsMap.put(3,'Mar');
        monthsMap.put(4,'Apr');
        monthsMap.put(5,'May');
        monthsMap.put(6,'Jun');
        monthsMap.put(7,'Jul');
        monthsMap.put(8,'Aug');
        monthsMap.put(9,'Sep');
        monthsMap.put(10,'Oct');
        monthsMap.put(11,'Nov');
        monthsMap.put(12,'Dec');
    }

    Public PageReference doSomething(){
        twList = new List<TestWrapper>();
        TestWrapper tw = null;
        List<Node> nodeList = new List<Node>();
        Node nod = null;
        
        Date startDate =  system.today();
        Date endDate = System.today().addMonths(10);
        Integer monthsCount = startDate.monthsBetween(endDate);
        System.debug('***** startDate = ' + startDate);
        System.debug('***** endDate = ' + endDate);
        String mmyyyy = null;
        
        for(Integer i = 0; i < monthsCount; i++){
            mmyyyy = monthsMap.get(startDate.addMonths(i).month()) + ' ' + String.valueOf(startDate.addMonths(i).year()).subString(2,4);
            monthHeader.add(mmyyyy);
        }
        System.debug('***** monthHeader = ' + monthHeader);
        
        for(Integer i=0; i < 10; i++){
            tw = new TestWrapper();
            tw.name = 'test' + i;
            nodeList = new List<Node>();
            
            for(Integer j=0; j < 10; j++){
                nod = new Node();
                nod.value = 'node' + i + j;
                nodeList.add(nod);
            }
            tw.nodes = nodeList;
            twList.add(tw);
        }
        return null;
    }
    
    public class TestWrapper {
        public String name {get;set;}
        public List<Node> nodes{get;set;}
    }
    public class Node {
        //public String key{set;get;}
        public String value{set;get;}
    }
}