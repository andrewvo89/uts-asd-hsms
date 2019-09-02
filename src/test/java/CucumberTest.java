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
public class CucumberTest {
   WebDriver driver; 
	
   @Given("^I am on the user management page$") 
   public void navigatePage() throws Throwable { 
        Class<? extends WebDriver> driverClass = ChromeDriver.class;
        WebDriverManager.getInstance(driverClass).setup();
        driver = driverClass.newInstance();
        driver.manage().timeouts().implicitlyWait(5, TimeUnit.SECONDS);
        driver.get("https://uts-asd-hsms.herokuapp.com/usermanagement.jsp");
        driver.findElement(By.id("email")).sendKeys("administrator@hsms.edu.au");
        driver.findElement(By.id("password")).sendKeys("Password!");
        driver.findElement(By.id("submit")).submit();
   } 
   
    @When("^I click on edit$") 
   public void clickEdit() throws Throwable { 
        driver.findElement(By.id("userEditButton")).click();
   } 
	
   @And("^change email to \"([^\"]*)\"$") 
   public void editLastName(String email) throws Throwable { 
        WebElement emailEdit = driver.findElement(By.id("emailEdit")); 
        emailEdit.clear();
        for (int x = 0; x < email.length(); x ++) {
            emailEdit.sendKeys(String.valueOf(email.charAt(x)));
        }
        driver.findElement(By.id("userEditConfirmButton")).submit();
   } 
	
   @Then("^I should get a message indicating \"([^\"]*)\"$") 
    public void getResult(String expectedResult) throws Throwable {
        String actualResult = driver.findElement(By.id("modalTrigger")).getAttribute("value");
        assertEquals(expectedResult, actualResult);
        driver.close();
    } 
}
