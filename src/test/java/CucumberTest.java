/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import io.github.bonigarcia.wdm.WebDriverManager;
import org.junit.Assert;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
/**
 *
 * @author Admin
 */
public class CucumberTest {
   WebDriver driver; 
	
   @Given("^I have opened the browser$") 
   public void openBrowser() throws Throwable { 
      Class<? extends WebDriver> driverClass = ChromeDriver.class;
        WebDriverManager.getInstance(driverClass).setup();
        driver = driverClass.newInstance();
        driver.get("http://localhost:8080/uts-asd-hsms/");
   } 
	
   @When("^Website is loaded$") 
   public void loadWebsite() throws Throwable { 
      driver.navigate().to(driver.getCurrentUrl());
   } 
	
   @Then("^Login button should exist$") 
   public void loginButton() throws Throwable { 
      if(driver.findElement(By.id("submit")).isEnabled()) { 
         System.out.println("Test 1 Pass"); 
      } else { 
         System.out.println("Test 1 Fail"); 
      } 
      driver.close(); 
   } 
}
