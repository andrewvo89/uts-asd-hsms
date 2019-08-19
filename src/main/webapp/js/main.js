//Pre-fill Edit User Modal

$('#userEditModal').on('show.bs.modal', function (event) {
  var button = $(event.relatedTarget) // Button that triggered the modal
  var userid = button.data('userid')
  var firstname = button.data('firstname')
  var lastname = button.data('lastname')
  var email = button.data('email')
  var password = button.data('password')
  var department = button.data('department')
  var userrolestring = button.data('userrolestring')
  var modal = $(this)
  modal.find('.modal-title').text('Edit ' + department + ' ' + userrolestring)
  modal.find('.userId input').val(userid)
  modal.find('.firstName input').val(firstname)
  modal.find('.lastName input').val(lastname)
  modal.find('.email input').val(email)
  modal.find('.password input').val(password)
  document.getElementById(department).checked = true
  document.getElementById(userrolestring).checked = true
})

$('#userDeleteModal').on('show.bs.modal', function (event) {
  var button = $(event.relatedTarget) // Button that triggered the modal
  var userid = button.data('userid')
  var firstname = button.data('firstname')
  var lastname = button.data('lastname')
  var modal = $(this)
  modal.find('.userId input').val(userid)
  modal.find('.modal-title').text('Delete ' + firstname + ' ' + lastname)
})
