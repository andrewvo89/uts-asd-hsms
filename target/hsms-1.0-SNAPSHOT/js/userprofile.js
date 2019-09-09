//Open Message Modal on Page Load
$(window).on('load', function() {
    var modalTrigger = document.getElementById('modalTrigger').value;
        
    if (modalTrigger != '') {
        $('#messageModal').modal('show');
    }
});

//Confirm Password Validation
$('#passwordedit, #passwordconfirmedit').on('keyup', function () {
    var passwordedit = document.getElementById("passwordedit");
    var passwordconfirmedit = document.getElementById("passwordconfirmedit")
    if (passwordedit.value !== passwordconfirmedit.value) {
      passwordconfirmedit.setCustomValidity("Passwords don't match");
    } 
    else {
      passwordconfirmedit.setCustomValidity("");
    }
});

//Reveal Password upon pressing Show Button
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