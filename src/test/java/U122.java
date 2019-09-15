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
 * @author Griffin
 */
public class U122 {
    WebDriver driver;
    
    @Given("I am on the class roll management page")
    public void navigatePage9() throws Throwable {
        Class<? extends WebDriver> driverClass = ChromeDriver.class;
        WebDriverManager.getInstance(driverClass).setup();
        driver = driverClass.newInstance();
        driver.manage().timeouts().implicitlyWait(5, TimeUnit.SECONDS);
        driver.get("https://uts-asd-hsms.herokuapp.com/classrollmanagement.jsp");
        driver.findElement(By.id("email")).sendKeys("administrator@hsms.edu.au");
        driver.findElement(By.id("password")).sendKeys("Password!");
        driver.findElement(By.id("submit")).submit();
    }
    
    @When("I click on edit on attendance$")
    public void clickEdit() throws Throwable {
        driver.findElement(By.id("attendanceEditButton0")).click();
    }
                        
    @And("I change wk1 to \"([^\"]*)\"$")
    public void editUser(String wk1) throws Throwable {
        WebElement wk1Edit = driver.findElement(By.id("wk1EditField0"));
        wk1Edit.clear();
        for (int x = 0; x < wk1.length(); x++) wk1Edit.sendKeys(String.valueOf(wk1.charAt(x)));
        driver.findElement(By.id("attendanceEditConfirmButton0")).submit();
    }
    
    @Then("I should get a message indicating <result>")
    public void getResult(String expectedResult) throws Throwable {
        String actualResult = driver.findElement(By.id("modalTrigger")).getAttribute("value");
        assertEquals(expectedResult, actualResult);
        driver.close();
    }
    
}
