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
class JobIdResult {
    public static String jobIdResult;  
}

public class JobFeature {
   private WebDriver driver;
   
    @Given("^I am on the job management page$") 
    public void NavigateJobManagement() throws Throwable { 
        Class<? extends WebDriver> driverClass = ChromeDriver.class;
        WebDriverManager.getInstance(driverClass).setup();
        driver = driverClass.newInstance();
        driver.manage().timeouts().implicitlyWait(5, TimeUnit.SECONDS);
        driver.get("https://uts-asd-hsms.herokuapp.com/jobmanagement.jsp");
        driver.findElement(By.id("email")).sendKeys("aaron@hsms.edu.au");
        driver.findElement(By.id("password")).sendKeys("Password!");
        driver.findElement(By.id("submit")).submit();
    }
    
    @Given("^I am on the job board page$") 
    public void NavigateJobBoard() throws Throwable { 
        Class<? extends WebDriver> driverClass = ChromeDriver.class;
        WebDriverManager.getInstance(driverClass).setup();
        driver = driverClass.newInstance();
        driver.manage().timeouts().implicitlyWait(5, TimeUnit.SECONDS);
        driver.get("https://uts-asd-hsms.herokuapp.com/jobboard.jsp");
        driver.findElement(By.id("email")).sendKeys("sally@hsms.edu.au");
        driver.findElement(By.id("password")).sendKeys("Password!");
        driver.findElement(By.id("submit")).submit();
    }
    @Given("^the job has been fulfilled$") 
    public void NavigateJobReview() throws Throwable { 
        NavigateJobManagement();
        driver.findElement(By.id("jobReviewButton" + JobIdResult.jobIdResult)).submit();
        driver.findElement(By.id("successButton0")).click();
        driver.findElement(By.id("successConfirmButton0")).submit();
        driver.get("https://uts-asd-hsms.herokuapp.com/jobmanagement.jsp");
    }   
    
    @When("^U104 I click on add job$") 
    public void U104ClickAdd() throws Throwable { 
        driver.findElement(By.id("jobAddButton")).click();
    }
    
    @And("^U104 I change the title to \"([^\"]*)\" description to \"([^\"]*)\" and close date to \"([^\"]*)\"$") 
    public void U104AddJob(String title, String description, String closeDate) throws Throwable {
        WebElement titleAdd = driver.findElement(By.id("titleAdd")); 
        WebElement descriptionAdd = driver.findElement(By.id("descriptionAdd"));
        WebElement closeDateAdd = driver.findElement(By.id("closeDateAdd"));
        WebElement departmentAdd = driver.findElement(By.id("departmentAddScience"));
        WebElement statusAdd = driver.findElement(By.id("statusAddOpen"));
        titleAdd.clear();
        for (int x = 0; x < title.length(); x ++) {
            titleAdd.sendKeys(String.valueOf(title.charAt(x)));
        }
        descriptionAdd.clear();
        for (int x = 0; x < description.length(); x ++) {
            descriptionAdd.sendKeys(String.valueOf(description.charAt(x)));
        }
        departmentAdd.click();
        statusAdd.click();
        closeDateAdd.click();
        closeDateAdd.sendKeys(closeDate);
        driver.findElement(By.id("jobAddConfirmationButton")).submit();
    }
    @Then("^U104 I should get a message indicating \"([^\"]*)\"$") 
    public void U104GetResult(String expectedResult) throws Throwable {
        String actualResult = driver.findElement(By.id("modalTrigger")).getAttribute("value");
        JobIdResult.jobIdResult = driver.findElement(By.id("jobIdResult")).getAttribute("value");
        assertEquals(expectedResult, actualResult);
        driver.close();
    }
    @When("^U105 I click on apply$") 
    public void U105ClickApply() throws Throwable { 
        driver.findElement(By.id("jobApplyButton" + JobIdResult.jobIdResult)).click();
    }
    @And("^U105 I write my cover letter as \"([^\"]*)\"$")
    public void U105ApplyJob(String coverLetter) throws Throwable {
        WebElement coverLetterApply = driver.findElement(By.id("coverLetter" + JobIdResult.jobIdResult));
        for (int x = 0; x < coverLetter.length(); x ++) {
            coverLetterApply.sendKeys(String.valueOf(coverLetter.charAt(x)));
        }
        driver.findElement(By.id("jobApplyConfirmButton" + JobIdResult.jobIdResult)).submit();
    }
    @Then("^U105 I should get a message indicating \"([^\"]*)\"$") 
    public void U105GetResult(String expectedResult) throws Throwable {
        String actualResult = driver.findElement(By.id("modalTrigger")).getAttribute("value");
        assertEquals(expectedResult, actualResult);
        driver.close();
    } 
   
    @When("^U106 I click on edit job$") 
    public void U106ClickEdit() throws Throwable { 
        driver.findElement(By.id("jobEditButton" + JobIdResult.jobIdResult)).click();
    } 
	
   @And("^U106 I change title to \"([^\"]*)\" and close date to \"([^\"]*)\"$") 
    public void U106EditJob(String title, String closeDate) throws Throwable { 
        WebElement titleEdit = driver.findElement(By.id("titleEdit" + JobIdResult.jobIdResult)); 
        WebElement closeDateEdit = driver.findElement(By.id("closeDateEdit" + JobIdResult.jobIdResult)); 
        titleEdit.clear();
        for (int x = 0; x < title.length(); x ++) {
            titleEdit.sendKeys(String.valueOf(title.charAt(x)));
        }
        closeDateEdit.click();
        closeDateEdit.sendKeys(closeDate);
        driver.findElement(By.id("jobEditConfirmButton" + JobIdResult.jobIdResult)).submit();
    } 
	
    @Then("^U106 I should get a message indicating \"([^\"]*)\"$") 
    public void U106GetResult(String expectedResult) throws Throwable {
        String actualResult = driver.findElement(By.id("modalTrigger")).getAttribute("value");
        assertEquals(expectedResult, actualResult);
        driver.close();
    }
    
    @When("^U107 I click on delete job$") 
    public void U107ClickDelete() throws Throwable {
        driver.findElement(By.id("jobDeleteButton" + JobIdResult.jobIdResult)).click();
    }
    
    @When("^U107 I confirm delete$") 
    public void U107ConfirmDelete() throws Throwable {
        driver.findElement(By.id("jobDeleteConfirmButton" + JobIdResult.jobIdResult)).submit();
    }
    
    @Then("^U107 I should get a message indicating \"([^\"]*)\"$") 
    public void U107GetResult(String expectedResult) throws Throwable {
        String actualResult = driver.findElement(By.id("modalTrigger")).getAttribute("value");
        assertEquals(expectedResult, actualResult);
        driver.close();
    }
}
