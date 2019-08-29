<%-- 
    Document   : rolemanagement
    Created on : 16 Aug. 2019, 7:14:12 pm
    Author     : Griffin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="org.bson.types.ObjectId"%>
<%@page import="uts.asd.hsms.model.dao.*"%>
<%@page import="uts.asd.hsms.model.*"%>
<%
    User user = (User)session.getAttribute("user");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
        <!-- Custom CSS -->
        <link rel="stylesheet" href="css/main.css">
        <title>Class Roll Management</title>
        <%
        if (user == null) {
            response.sendRedirect("index.jsp?redirect=classrollmanagement");
        }
        else {
        %>
            <%@ include file="/WEB-INF/jspf/header-loggedin.jspf" %>
        <%
        }
        %>
    </head>
    
    <body>
        <div class="main">
            <div class="container">
                <h1>Class-roll Management</h1>
                
                <!-- Div for filter section -->
                <div class="card" style="margin-top:25px">
                    <div class="card-header">
                        <button type="button" class="btn btn-secondary" data-toggle="collapse" href="#collapseExample" role="button" aria-expanded="false" aria-controls="collapseExample" data-toggle="button">Filter</button>
                    </div>
                    <div class="collapse" id="collapseExample">
                        <div class="card-body">
                            <form action="">
                            <div class="form-row">
                                <div class="form-group col-md-6">
                                    <label for="firstName">Class ID</label>
                                    <input type="text" class="form-control" id="classId" placeholder="Class ID">
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="lastName">Department</label>
                                    <input type="text" class="form-control" id="department" placeholder="Department">
                                </div>
                            </div>
                                <div class="form-row">
                                    <div class="form-group col-md-7">
                                        <label for="departmentSearch">Grade</label>
                                        <div class="form-check">
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="gradeSearch" id="all" value="all" checked>
                                                <label class="form-check-label" for="all">All</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="gradeSearch" id="7" value="7">
                                                <label class="form-check-label" for="7">7</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="gradeSearch" id="8" value="8">
                                                <label class="form-check-label" for="8">8</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="gradeSearch" id="9" value="9">
                                                <label class="form-check-label" for="9">9</label>
                                            </div>   
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="gradeSearch" id="10" value="10">
                                                <label class="form-check-label" for="10">10</label>
                                            </div>   
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="gradeSearch" id="11" value="11">
                                                <label class="form-check-label" for="11">11</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="gradeSearch" id="12" value="12">
                                                <label class="form-check-label" for="12">12</label>
                                            </div> 
                                        </div>
                                    </div>
                                </div> 
                                <button type="submit" class="btn btn-primary mb-2">Search</button>
                            </form> 
                     </div>
                    </div>
                </div>
                
                    <br><table class="table" id="tutTable">
                        <thead class="thead-light">
                            <tr>
                                <th scope="col">Class ID</th>
                                <th scope="col">Department</th>
                                <th scope="col">Grade</th>
                                <th scope="col">Class Size</th>
                            </tr>
                        </thead>
                        <tbody> 
                            <%
                                TutorialDao tutorialDao = (TutorialDao)session.getAttribute("tutorialDao");
                                Tutorial[] tutorials = tutorialDao.getTutorials();
                                for (int x = 0; x < tutorials.length; x++) {
                                    Tutorial currentTut = tutorials[x];
                                    String refId = currentTut.getRefIdString(); 
                                    String tutorialId = currentTut.getTutorialId();
                                    String department = currentTut.getDepartment();
                                    int grade = currentTut.getGrade();
                                    String userId = currentTut.getUserIdString();
                                    int tutSize = currentTut.getTutSize();  
                            %>
                            <tr>
                                <td><%=tutorialId%></td>
                                <td><%=department%></td>
                                <td><%=grade%></td>
                                <td><%=tutSize%></td>
                            <%
                                }
                            %>
                            </tr> 
                        </tbody>
                    </table>
            </div>   
            
            
            <!--Div for roll edit -->
            <div class="modal fade" id="editRollModal" tabindex="-1" role="dialog" aria-labelledby="editRoll" aria-hidden="true">
                                    <div class="modal-dialog" role="document">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="editRollModalLabel">M1010 Math Year 8</h5>
                                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                    <span aria-hidden="true">&times;</span>
                                                </button>
                                            </div>
                                            <div class="modal-body">
                                                <form action="">
                                                    <table class="table">
                                                        <thead class="thead-light">
                                                            <tr>
                                                                <th class="col-sm-6">Student</th>
                                                                <th class="col-sm-2">Week 1</th>
                                                                <th class="col-sm-2">Week 2</th>
                                                                <th class="col-sm-2">Week 3</th>
                                                                <th class="col-sm-2">Week 4</th>
                                                                <th class="col-sm-2">Week 5</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <tr>
                                                                <td>Jessica Simpson</td>
                                                                <td><input class="form-check-input" type="radio" name="week1" id="w1"></td>
                                                                <td><input class="form-check-input" type="radio" name="week2" id="w2"></td>
                                                                <td><input class="form-check-input" type="radio" name="week3" id="w3"></td>
                                                                <td><input class="form-check-input" type="radio" name="week4" id="w4"></td>
                                                                <td><input class="form-check-input" type="radio" name="week5" id="w5"></td>
                                                            </tr>
                                                            <tr>
                                                                <td>Lil Nas X</td>
                                                                <td><input class="form-check-input" type="radio" name="week1" id="w1"></td>
                                                                <td><input class="form-check-input" type="radio" name="week2" id="w2"></td>
                                                                <td><input class="form-check-input" type="radio" name="week3" id="w3"></td>
                                                                <td><input class="form-check-input" type="radio" name="week4" id="w4"></td>
                                                                <td><input class="form-check-input" type="radio" name="week5" id="w5"></td>
                                                            </tr>
                                                            <tr>
                                                                <td>Shawn Mendes</td>
                                                                <td><input class="form-check-input" type="radio" name="week1" id="w1"></td>
                                                                <td><input class="form-check-input" type="radio" name="week2" id="w2"></td>
                                                                <td><input class="form-check-input" type="radio" name="week3" id="w3"></td>
                                                                <td><input class="form-check-input" type="radio" name="week4" id="w4"></td>
                                                                <td><input class="form-check-input" type="radio" name="week5" id="w5"></td>
                                                            </tr>
                                                            <tr>
                                                                <td>Camila (Senorita) Cabello</td>
                                                                <td><input class="form-check-input" type="radio" name="week1" id="w1"></td>
                                                                <td><input class="form-check-input" type="radio" name="week2" id="w2"></td>
                                                                <td><input class="form-check-input" type="radio" name="week3" id="w3"></td>
                                                                <td><input class="form-check-input" type="radio" name="week4" id="w4"></td>
                                                                <td><input class="form-check-input" type="radio" name="week5" id="w5"></td>
                                                            </tr>
                                                            <tr>
                                                                <td>Beyonce</td>
                                                                <td><input class="form-check-input" type="radio" name="week1" id="w1"></td>
                                                                <td><input class="form-check-input" type="radio" name="week2" id="w2"></td>
                                                                <td><input class="form-check-input" type="radio" name="week3" id="w3"></td>
                                                                <td><input class="form-check-input" type="radio" name="week4" id="w4"></td>
                                                                <td><input class="form-check-input" type="radio" name="week5" id="w5"></td>
                                                            </tr>
                                                            <tr>
                                                                <td>Barack Obama</td>
                                                                <td><input class="form-check-input" type="radio" name="week1" id="w1"></td>
                                                                <td><input class="form-check-input" type="radio" name="week2" id="w2"></td>
                                                                <td><input class="form-check-input" type="radio" name="week3" id="w3"></td>
                                                                <td><input class="form-check-input" type="radio" name="week4" id="w4"></td>
                                                                <td><input class="form-check-input" type="radio" name="week5" id="w5"></td>
                                                            </tr>
                                                            <tr>
                                                                <td>Taika Waititi</td>
                                                                <td><input class="form-check-input" type="radio" name="week1" id="w1"></td>
                                                                <td><input class="form-check-input" type="radio" name="week2" id="w2"></td>
                                                                <td><input class="form-check-input" type="radio" name="week3" id="w3"></td>
                                                                <td><input class="form-check-input" type="radio" name="week4" id="w4"></td>
                                                                <td><input class="form-check-input" type="radio" name="week5" id="w5"></td>
                                                            </tr>
                                                            <tr>
                                                                <td>Sandra Oh</td>
                                                                <td><input class="form-check-input" type="radio" name="week1" id="w1"></td>
                                                                <td><input class="form-check-input" type="radio" name="week2" id="w2"></td>
                                                                <td><input class="form-check-input" type="radio" name="week3" id="w3"></td>
                                                                <td><input class="form-check-input" type="radio" name="week4" id="w4"></td>
                                                                <td><input class="form-check-input" type="radio" name="week5" id="w5"></td>
                                                            </tr>
                                                            <tr>
                                                                <td>Kahlme Anithyme</td>
                                                                <td><input class="form-check-input" type="radio" name="week1" id="w1"></td>
                                                                <td><input class="form-check-input" type="radio" name="week2" id="w2"></td>
                                                                <td><input class="form-check-input" type="radio" name="week3" id="w3"></td>
                                                                <td><input class="form-check-input" type="radio" name="week4" id="w4"></td>
                                                                <td><input class="form-check-input" type="radio" name="week5" id="w5"></td>
                                                            </tr>
                                                            <tr>
                                                                <td>Sia Laytor</td>
                                                                <td><input class="form-check-input" type="radio" name="week1" id="w1"></td>
                                                                <td><input class="form-check-input" type="radio" name="week2" id="w2"></td>
                                                                <td><input class="form-check-input" type="radio" name="week3" id="w3"></td>
                                                                <td><input class="form-check-input" type="radio" name="week4" id="w4"></td>
                                                                <td><input class="form-check-input" type="radio" name="week5" id="w5"></td>
                                                            </tr>
                                                        </tbody>
                                                        <button type="save" class="btn btn-primary mb-2">Save</button>
                                                    </table>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
            </div>
        </div>
            
        <%@ include file="/WEB-INF/jspf/footer-static.jspf" %>        
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
        <script src="js/main.js"></script>
    </body>
</html>
