//Pre-fill Edit User Modal

$('#userEditModal').on('show.bs.modal', function(event) {
  var button = $(event.relatedTarget) // Button that triggered the modal
  var userid = button.data('userid')
  var firstname = button.data('firstname')
  var lastname = button.data('lastname')
  var email = button.data('email')
  var department = button.data('department')
  var userrolestring = button.data('userrolestring')
  var modal = $(this)
  modal.find('.modal-title').text('Edit ' + firstname + ' ' + lastname)
  modal.find('.userId input').val(userid)
  modal.find('.firstName input').val(firstname)
  modal.find('.lastName input').val(lastname)
  modal.find('.email input').val(email)
  document.getElementById(department).checked = true
  document.getElementById(userrolestring).checked = true
})

$('#userDeleteModal').on('show.bs.modal', function(event) {
  var button = $(event.relatedTarget) // Button that triggered the modal
  var userid = button.data('userid')
  var firstname = button.data('firstname')
  var lastname = button.data('lastname')
  var modal = $(this)
  modal.find('.userId input').val(userid)
  modal.find('.modal-title').text('Delete ' + firstname + ' ' + lastname)
})


$(window).on('load', function() {
    var modalTrigger = document.getElementById('modalTrigger').value;
        
    if (modalTrigger == 'messageModal') {
        $('#messageModal').modal('show');
    }
    else if (modalTrigger == 'addModal') {
        $('#userAddModal').modal('show');
    }   
});

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