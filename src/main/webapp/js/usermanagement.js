//After HTML page loads
$(window).on("load", function() {
    var modalTrigger = document.getElementById("modalTrigger").value;        
    if (modalTrigger != "") {
        $("#messageModal").modal("show");
    }
    checkDepartment();
    checkUserRole();
});

//Password Confirm field valition
$("#passwordAdd, #passwordConfirmAdd").on("keyup", function () {
    var passwordAdd = document.getElementById("passwordAdd");
    var passwordConfirmAdd = document.getElementById("passwordConfirmAdd");
    if (passwordAdd.value !== passwordConfirmAdd.value) {
      passwordConfirmAdd.setCustomValidity("Passwords don't match");
    } 
    else {
      passwordConfirmAdd.setCustomValidity("");
    }
});
$("[id^=passwordEdit], [id^=passwordConfirmEdit]").on("keyup", function (event) {
    var inputField = $(event.target);
    var index = inputField.data("index");
    var passwordEdit = document.getElementById("passwordEdit" + index);
    var passwordConfirmEdit = document.getElementById("passwordConfirmEdit" + index);
    if (passwordEdit.value !== passwordConfirmEdit.value) {
      passwordConfirmEdit.setCustomValidity("Passwords don't match");
    } 
    else {
      passwordConfirmEdit.setCustomValidity("");
    }
});

//Reveal Password upon pressing Show Button
$("#revealAdd").on("click", function () {
    var passwordField = $("#passwordAdd");
    if (passwordField.attr("type") === "password") {
        passwordField.attr("type", "text");
    } else {
        passwordField.attr("type", "password");
    }
});
$("#revealConfirmAdd").on("click", function () {
    var passwordField = $("#passwordConfirmAdd");
    if (passwordField.attr("type") === "password") {
        passwordField.attr("type", "text");
    } else {
        passwordField.attr("type", "password");
    }
});
$("[id^=revealEdit]").on("click", function () {
    var button = $(event.target);
    var index = button.data("index");
    var passwordField = $("#passwordEdit" + index);
    if (passwordField.attr("type") === "password") {
        passwordField.attr("type", "text");
    } else {
        passwordField.attr("type", "password");
    }
});
$("[id^=revealConfirmEdit]").on("click", function () {
    var button = $(event.target);
    var index = button.data("index");
    var passwordField = $("#passwordConfirmEdit" + index);
    if (passwordField.attr("type") === "password") {
        passwordField.attr("type", "text");
    } else {
        passwordField.attr("type", "password");
    }
});
$("input[name=departmentSearch]").on("change",function() {
    checkDepartment();
});
$("input[name=userRoleSearch]").on("change",function() {
    checkUserRole();
});

//Change Pill button status based on Radio Button selected
function checkDepartment() {
    $("#departmentButtonAdministration").removeClass("active");
    $("#departmentButtonEnglish").removeClass("active");
    $("#departmentButtonMath").removeClass("active");
    $("#departmentButtonScience").removeClass("active");
    $("#departmentButtonArt").removeClass("active");
    if ($("input[id=departmentSearchAdministration]").prop("checked")) {
        $("#departmentButtonAdministration").addClass("active");
    }
    else if ($("input[id=departmentSearchEnglish]").prop("checked")) {
        $("#departmentButtonEnglish").addClass("active");
    }
    else if ($("input[id=departmentSearchMath]").prop("checked")) {
        $("#departmentButtonMath").addClass("active");
    }
    else if ($("input[id=departmentSearchScience]").prop("checked")) {
        $("#departmentButtonScience").addClass("active");
    }
    else if ($("input[id=departmentSearchArt]").prop("checked")) {
        $("#departmentButtonArt").addClass("active");
    }
}

function checkUserRole() {
    $("#userRoleButtonAdministrator").removeClass("active");
    $("#userRoleButtonPrincipal").removeClass("active");
    $("#userRoleButtonHeadTeacher").removeClass("active");
    $("#userRoleButtonTeacher").removeClass("active");
    if ($("input[id=userRoleSearchAdministrator]").prop("checked")) {
        $("#userRoleButtonAdministrator").addClass("active");
    }
    else if ($("input[id=userRoleSearchPrincipal]").prop("checked")) {
        $("#userRoleButtonPrincipal").addClass("active");
    }
    else if ($("input[id=userRoleSearchHeadTeacher]").prop("checked")) {
        $("#userRoleButtonHeadTeacher").addClass("active");
    }
    else if ($("input[id=userRoleSearchTeacher]").prop("checked")) {
        $("#userRoleButtonTeacher").addClass("active");
    }
}

//Department Button Actions
$("#departmentButtonAdministration").on("click",function() {
    document.getElementById("departmentSearchAdministration").checked = true;
    document.getElementById("searchButton").click();
});
$("#departmentButtonEnglish").on("click",function() {
    document.getElementById("departmentSearchEnglish").checked = true;
    document.getElementById("searchButton").click();
});
$("#departmentButtonMath").on("click",function() {
    document.getElementById("departmentSearchMath").checked = true;
    document.getElementById("searchButton").click();
});
$("#departmentButtonScience").on("click",function() {
    document.getElementById("departmentSearchScience").checked = true;
    document.getElementById("searchButton").click();
});
$("#departmentButtonArt").on("click",function() {
    document.getElementById("departmentSearchArt").checked = true;
    document.getElementById("searchButton").click();
});

//User Role Button Actions
$("#userRoleButtonAdministrator").on("click",function() {
    document.getElementById("userRoleSearchAdministrator").checked = true;
    document.getElementById("searchButton").click();
});
$("#userRoleButtonPrincipal").on("click",function() {
    document.getElementById("userRoleSearchPrincipal").checked = true;
    document.getElementById("searchButton").click();
});
$("#userRoleButtonHeadTeacher").on("click",function() {
    document.getElementById("userRoleSearchHeadTeacher").checked = true;
    document.getElementById("searchButton").click();
});
$("#userRoleButtonTeacher").on("click",function() {
    document.getElementById("userRoleSearchTeacher").checked = true;
    document.getElementById("searchButton").click();
});