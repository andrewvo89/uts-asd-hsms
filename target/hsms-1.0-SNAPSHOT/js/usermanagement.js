$(window).on('load', function() {
    var modalTrigger = document.getElementById('modalTrigger').value;        
    if (modalTrigger != '') {
        $('#messageModal').modal('show');
    }
    checkDepartment();
    checkUserRole();
});

//Password Confirm field valition

$('#passwordadd, #passwordconfirmadd').on('keyup', function () {
    var passwordadd = document.getElementById("passwordadd");
    var passwordconfirmadd = document.getElementById("passwordconfirmadd")
    if (passwordadd.value !== passwordconfirmadd.value) {
      passwordconfirmadd.setCustomValidity("Passwords don't match");
    } 
    else {
      passwordconfirmadd.setCustomValidity("");
    }
});

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


//Pre-fill Edit User Modal
$('#userEditModal').on('show.bs.modal', function(event) {
  var button = $(event.relatedTarget); // Button that triggered the modal
  var userid = button.data('userid');
  var firstname = button.data('firstname');
  var lastname = button.data('lastname');
  var phone = button.data('phone');
  var location = button.data('location');
  var email = button.data('email');
  var department = button.data('department');
  var userrolestring = button.data('userrolestring');
  var modal = $(this);
  modal.find('.modal-title').text('Edit ' + firstname + ' ' + lastname);
  modal.find('.userId input').val(userid);
  modal.find('.firstName input').val(firstname);
  modal.find('.lastName input').val(lastname);
  modal.find('.phone input').val(phone);
  modal.find('.location input').val(location);
  modal.find('.email input').val(email);
  document.getElementById(department).checked = true;
  document.getElementById(userrolestring).checked = true;
});

//Pre-fill Delete User Modal
$('#userDeleteModal').on('show.bs.modal', function(event) {
  var button = $(event.relatedTarget); // Button that triggered the modal
  var userid = button.data('userid');
  var firstname = button.data('firstname');
  var lastname = button.data('lastname');
  var modal = $(this);
  modal.find('.userId input').val(userid);
  modal.find('.modal-title').text('Delete ' + firstname + ' ' + lastname);
});


$('input[name=departmentSearch]').on('change',function() {
    checkDepartment();
});
$('input[name=userRoleSearch]').on('change',function() {
    checkUserRole();
});


//Change Pill button status based on Radio Button selected
function checkDepartment() {
    $("#departmentButtonAdministration").removeClass('active');
    $("#departmentButtonEnglish").removeClass('active');
    $("#departmentButtonMath").removeClass('active');
    $("#departmentButtonScience").removeClass('active');
    $("#departmentButtonArt").removeClass('active');
    if ($('input[id=departmentSearchAdministration]').prop('checked')) {
        $("#departmentButtonAdministration").addClass('active');
    }
    else if ($('input[id=departmentSearchEnglish]').prop('checked')) {
        $("#departmentButtonEnglish").addClass('active');
    }
    else if ($('input[id=departmentSearchMath]').prop('checked')) {
        $("#departmentButtonMath").addClass('active');
    }
    else if ($('input[id=departmentSearchScience]').prop('checked')) {
        $("#departmentButtonScience").addClass('active');
    }
    else if ($('input[id=departmentSearchArt]').prop('checked')) {
        $("#departmentButtonArt").addClass('active');
    }
}

function checkUserRole() {
    $("#userRoleButtonAdministrator").removeClass('active');
    $("#userRoleButtonPrincipal").removeClass('active');
    $("#userRoleButtonHeadTeacher").removeClass('active');
    $("#userRoleButtonTeacher").removeClass('active');
    if ($('input[id=userRoleSearchAdministrator]').prop('checked')) {
        $("#userRoleButtonAdministrator").addClass('active');
    }
    else if ($('input[id=userRoleSearchPrincipal]').prop('checked')) {
        $("#userRoleButtonPrincipal").addClass('active');
    }
    else if ($('input[id=userRoleSearchHeadTeacher]').prop('checked')) {
        $("#userRoleButtonHeadTeacher").addClass('active');
    }
    else if ($('input[id=userRoleSearchTeacher]').prop('checked')) {
        $("#userRoleButtonTeacher").addClass('active');
    }
}

//Department Button Actions
$("#departmentButtonAdministration").on('click',function() {
    document.getElementById('departmentSearchAdministration').checked = true;
    document.getElementById('searchButton').click();
});
$("#departmentButtonEnglish").on('click',function() {
    document.getElementById('departmentSearchEnglish').checked = true;
    document.getElementById('searchButton').click();
});
$("#departmentButtonMath").on('click',function() {
    document.getElementById('departmentSearchMath').checked = true;
    document.getElementById('searchButton').click();
});
$("#departmentButtonScience").on('click',function() {
    document.getElementById('departmentSearchScience').checked = true;
    document.getElementById('searchButton').click();
});
$("#departmentButtonArt").on('click',function() {
    document.getElementById('departmentSearchArt').checked = true;
    document.getElementById('searchButton').click();
});

//User Role Button Actions
$("#userRoleButtonAdministrator").on('click',function() {
    document.getElementById('userRoleSearchAdministrator').checked = true;
    document.getElementById('searchButton').click();
});
$("#userRoleButtonPrincipal").on('click',function() {
    document.getElementById('userRoleSearchPrincipal').checked = true;
    document.getElementById('searchButton').click();
});
$("#userRoleButtonHeadTeacher").on('click',function() {
    document.getElementById('userRoleSearchHeadTeacher').checked = true;
    document.getElementById('searchButton').click();
});
$("#userRoleButtonTeacher").on('click',function() {
    document.getElementById('userRoleSearchTeacher').checked = true;
    document.getElementById('searchButton').click();
});