public class compositionExample{

    String name;
    Integer age;
    String meal;
    String color;
    
    Boolean showGreeting = false;
    public InnserClass myInner {set;get{return new InnserClass();}}
    
    private class InnserClass{
    
    }
    
    public PageReference save() {
        showGreeting = true;
        return null;
    }
    
    public void setNameField(String nameField) {
        name = nameField;
    }
    
    public String getNameField() {
        return name;
    }
    
    public void setAgeField(Integer ageField) {
        age= ageField;
    }
    
    public Integer getAgeField() {
        return age;
    }
    
    public void setMealField(String mealField) {
        meal= mealField;
    }
    
    public String getMealField() {
        return meal;
    }   
         
    public void setColorField(String colorField) {
        color = colorField;
    }
    
    public String getColorField() {
        return color;
    }       
    
    public Boolean getShowGreeting() {
        return showGreeting;
    }
}