/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import cucumber.api.java.en.And;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import io.github.bonigarcia.wdm.WebDriverManager;
import java.util.concurrent.TimeUnit;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import static org.junit.Assert.*;

/**
 *
 * @author Andrew
 */
public class UserFeature {
//   WebDriver driver; 
//	
//   @Given("^I am on the user management page$") 
//   public void NavigateUserManagement() throws Throwable { 
//        Class<? extends WebDriver> driverClass = ChromeDriver.class;
//        WebDriverManager.getInstance(driverClass).setup();
//        driver = driverClass.newInstance();
//        driver.manage().timeouts().implicitlyWait(5, TimeUnit.SECONDS);
//        driver.get("https://uts-asd-hsms.herokuapp.com/usermanagement.jsp");
//        driver.findElement(By.id("email")).sendKeys("administrator@hsms.edu.au");
//        driver.findElement(By.id("password")).sendKeys("Password!");
//        driver.findElement(By.id("submit")).submit();
//   } 
//   
//    @When("^U102 I click on edit$") 
//   public void U102ClickEdit() throws Throwable { 
//        driver.findElement(By.id("userEditButton0")).click();
//   } 
//	
//   @And("^U102 I change phone to \"([^\"]*)\" and email to \"([^\"]*)\"$") 
//   public void U102EditUser(String phone, String email) throws Throwable { 
//        WebElement phoneEdit = driver.findElement(By.id("phoneEdit0")); 
//        WebElement emailEdit = driver.findElement(By.id("emailEdit0")); 
//        phoneEdit.clear();
//        for (int x = 0; x < phone.length(); x ++) {
//            phoneEdit.sendKeys(String.valueOf(phone.charAt(x)));
//        }
//        emailEdit.clear();
//        for (int x = 0; x < email.length(); x ++) {
//            emailEdit.sendKeys(String.valueOf(email.charAt(x)));
//        }
//        driver.findElement(By.id("userEditConfirmButton0")).submit();
//   } 
//	
//   @Then("^U102 I should get a message indicating \"([^\"]*)\"$") 
//    public void U102GetResult(String expectedResult) throws Throwable {
//        String actualResult = driver.findElement(By.id("modalTrigger")).getAttribute("value");
//        assertEquals(expectedResult, actualResult);
//        driver.close();
//    } 
}
