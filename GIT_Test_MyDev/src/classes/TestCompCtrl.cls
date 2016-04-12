public class TestCompCtrl {
    
      // Constructor method
      public TestCompCtrl() {
            if (selectedValue != null) {
                EditMode = true;
            }
      }
      
      private Boolean EditMode = false;

      // Setter method
      public String selectedValue { get;set; }
}