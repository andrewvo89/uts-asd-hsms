/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Griffin
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
import org.openqa.selenium.support.ui.Select;
import static org.junit.Assert.*;

class RefCommentIdResult {
    public static String refCommentIdResult;
}

public class FeedbackFeature {
    private WebDriver driver;
    
    @Given("^I am on the complaint fill page$")
    public void NavigateComplaintFill() throws Throwable {
        Class<? extends WebDriver> driverClass = ChromeDriver.class;
        WebDriverManager.getInstance(driverClass).setup();
        driver = driverClass.newInstance();
        driver.manage().timeouts().implicitlyWait(5, TimeUnit.SECONDS);
        driver.get("https://uts-asd-hsms.herokuapp.com/complaintfill.jsp");
        driver.findElement(By.id("email")).sendKeys("sally@hsms.edu.au");
        driver.findElement(By.id("password")).sendKeys("Password!");
        driver.findElement(By.id("submit")).submit();
    }
    
    @When("^U124 I change the comment subject to \"([^\"]*)\"$")
    public void U124EditSubject(String commSubject) throws Throwable {
        Select drpSubject = new Select(driver.findElement(By.name("commSubjectAdd")));
        drpSubject.selectByValue("Harassment");
    }
    
    @And("^U124 I write my comment as \"([^\"]*)\"$")
    public void U124EditComment(String comment) throws Throwable {
        WebElement commentFill = driver.findElement(By.id("commentAdd"));
        commentFill.sendKeys("I am being cat called.");
    }
    
    @Then("^U124 I should get a message indicating \"([^\"]*)\"$")
    public void U124GetResult(String expectedResult) throws Throwable {
        String actualResult = driver.findElement(By.id("feedbackSuccess")).getAttribute("value");
        assertEquals(expectedResult, actualResult);
        driver.close();
    }
}
