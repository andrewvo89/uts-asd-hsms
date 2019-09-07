//Confirm Password Validation
var passwordadd = document.getElementById("passwordadd");
var passwordconfirmadd = document.getElementById("passwordconfirmadd");
var passwordedit = document.getElementById("passwordedit");
var passwordconfirmedit = document.getElementById("passwordconfirmedit");

function validatePasswordAdd(){
  if(passwordadd.value != passwordconfirmadd.value) {
    passwordconfirmadd.setCustomValidity("Passwords don't match");
  } else {
    passwordconfirmadd.setCustomValidity('');
  }
}
function validatePasswordEdit(){
  if(passwordedit.value != passwordconfirmedit.value) {
    passwordconfirmedit.setCustomValidity("Passwords don't match");
  } else {
    passwordconfirmedit.setCustomValidity('');
  }
}

passwordadd.onchange = validatePasswordAdd;
passwordconfirmadd.onkeyup = validatePasswordAdd;
passwordedit.onchange = validatePasswordEdit;
passwordconfirmedit.onkeyup = validatePasswordEdit;

//Open Message Modal on Page Load
$(window).on('load', function() {
    var modalTrigger = document.getElementById('modalTrigger').value;
        
    if (modalTrigger != '') {
        $('#messageModal').modal('show');
    }
});

//Pre-fill Edit User Modal
$('#userEditModal').on('show.bs.modal', function(event) {
  var button = $(event.relatedTarget) // Button that triggered the modal
  var userid = button.data('userid')
  var firstname = button.data('firstname')
  var lastname = button.data('lastname')
  var phone = button.data('phone')
  var location = button.data('location')
  var email = button.data('email')
  var department = button.data('department')
  var userrolestring = button.data('userrolestring')
  var modal = $(this)
  modal.find('.modal-title').text('Edit ' + firstname + ' ' + lastname)
  modal.find('.userId input').val(userid)
  modal.find('.firstName input').val(firstname)
  modal.find('.lastName input').val(lastname)
  modal.find('.phone input').val(phone)
  modal.find('.location input').val(location)
  modal.find('.email input').val(email)
  document.getElementById(department).checked = true
  document.getElementById(userrolestring).checked = true
})

//Pre-fill Delete User Modal
$('#userDeleteModal').on('show.bs.modal', function(event) {
  var button = $(event.relatedTarget) // Button that triggered the modal
  var userid = button.data('userid')
  var firstname = button.data('firstname')
  var lastname = button.data('lastname')
  var modal = $(this)
  modal.find('.userId input').val(userid)
  modal.find('.modal-title').text('Delete ' + firstname + ' ' + lastname)
})

//Reveal Password upon pressing Show Button
$(".revealadd1").on('click',function() {
    var $pwd = $(".pwdadd1");
    if ($pwd.attr('type') === 'password') {
        $pwd.attr('type', 'text');
    } else {
        $pwd.attr('type', 'password');
    }
});

$(".revealadd2").on('click',function() {
    var $pwd = $(".pwdadd2");
    if ($pwd.attr('type') === 'password') {
        $pwd.attr('type', 'text');
    } else {
        $pwd.attr('type', 'password');
    }
});

$(".revealedit1").on('click',function() {
    var $pwd = $(".pwdedit1");
    if ($pwd.attr('type') === 'password') {
        $pwd.attr('type', 'text');
    } else {
        $pwd.attr('type', 'password');
    }
});

$(".revealedit2").on('click',function() {
    var $pwd = $(".pwdedit2");
    if ($pwd.attr('type') === 'password') {
        $pwd.attr('type', 'text');
    } else {
        $pwd.attr('type', 'password');
    }
});