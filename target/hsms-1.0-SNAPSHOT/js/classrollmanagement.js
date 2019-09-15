
$('#editRollModal').on('show.bs.modal', function(event) {
  var button = $(event.relatedTarget) // Button that triggered the modal
  var tutorialId = button.data('tutorialId')
  var modal = $(this)
  modal.find('.modal-title').text(tutorialId)
  modal.find('.tutorialId input').val(tutorialId)
})