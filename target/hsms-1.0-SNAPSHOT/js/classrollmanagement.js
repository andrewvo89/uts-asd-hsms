/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


$('#editRollModal').on('show.bs.modal', function(event) {
  var button = $(event.relatedTarget) // Button that triggered the modal
  var tutorialId = button.data('tutorialId')
  var modal = $(this)
  modal.find('.modal-title').text(tutorialId)
  modal.find('.tutorialId input').val(tutorialId)
})

