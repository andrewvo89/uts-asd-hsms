//Open Message Modal on Page Load
$(window).on("load", function () {
    var modalTrigger = document.getElementById("modalTrigger").value;
    if (modalTrigger != "") {
        $("#messageModal").modal("show");
    }
});

//Confirm Password Validation
$("#passwordEdit, #passwordConfirmEdit").on("keyup", function () {
    var passwordEdit = document.getElementById("passwordEdit");
    var passwordConfirmEdit = document.getElementById("passwordConfirmEdit")
    if (passwordEdit.value !== passwordConfirmEdit.value) {
        passwordConfirmEdit.setCustomValidity("Passwords don't match");
    } else {
        passwordConfirmEdit.setCustomValidity("");
    }
});

//Reveal Password upon pressing Show Button
$("#revealEdit").on("click", function () {
    var passwordField = $("#passwordEdit");
    if (passwordField.attr("type") === "password") {
        passwordField.attr("type", "text");
    } else {
        passwordField.attr("type", "password");
    }
});
$("#revealConfirmEdit").on("click", function () {
    var passwordField = $("#passwordConfirmEdit");
    if (passwordField.attr("type") === "password") {
        passwordField.attr("type", "text");
    } else {
        passwordField.attr("type", "password");
    }
});