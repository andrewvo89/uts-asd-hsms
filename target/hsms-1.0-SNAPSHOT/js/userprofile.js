//Open Message Modal on Page Load
$(window).on('load', function() {
    var modalTrigger = document.getElementById('modalTrigger').value;
        
    if (modalTrigger != '') {
        $('#messageModal').modal('show');
    }
});

//Confirm Password Validation
var passwordedit = document.getElementById("passwordedit");
var passwordconfirmedit = document.getElementById("passwordconfirmedit");

function validatePasswordEdit(){
  if(passwordedit.value != passwordconfirmedit.value) {
    passwordconfirmedit.setCustomValidity("Passwords don't match");
  } else {
    passwordconfirmedit.setCustomValidity('');
  }
}

passwordedit.onchange = validatePasswordEdit;
passwordconfirmedit.onkeyup = validatePasswordEdit;

$(".reveal1").on('click',function() {
    var $pwd = $(".pwd1");
    if ($pwd.attr('type') === 'password') {
        $pwd.attr('type', 'text');
    } else {
        $pwd.attr('type', 'password');
    }
});

$(".reveal2").on('click',function() {
    var $pwd = $(".pwd2");
    if ($pwd.attr('type') === 'password') {
        $pwd.attr('type', 'text');
    } else {
        $pwd.attr('type', 'password');
    }
});