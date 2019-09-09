//Pre-fill Add Job Modal
$('#jobAddModal').on('show.bs.modal', function(event) {
  var button = $(event.relatedTarget); // Button that triggered the modal
  var closedate = button.data('closedate');
  var modal = $(this);
  modal.find('.closedate input').val(closedate);
});

//Pre-fill Edit Job Modal
$('#jobEditModal').on('show.bs.modal', function(event) {
  var button = $(event.relatedTarget); // Button that triggered the modal
  var jobid = button.data('jobid');
  var title = button.data('title');
  var worktype = button.data('worktype');
  var department = button.data('department');
  var status = button.data('status');
  var closedate = button.data('closedate');
  var modal = $(this);
  modal.find('.modal-title').text('Edit ' + title);
  modal.find('.jobId input').val(jobid);
  modal.find('.title input').val(title);
  modal.find('.closedate input').val(closedate);
  document.getElementById(worktype).checked = true;
  document.getElementById(department).checked = true;
  document.getElementById(status).checked = true;
});

//Pre-fill Delete Job Modal
$('#jobDeleteModal').on('show.bs.modal', function(event) {
  var button = $(event.relatedTarget); // Button that triggered the modal
  var jobid = button.data('jobid');
  var title = button.data('title');
  var modal = $(this);
  modal.find('.jobId input').val(jobid);
  modal.find('.modal-title').text('Delete ' + title);
});

//Upon page loading
$(window).on('load', function() {
    checkWorkType();
    checkStatus();
    checkDepartment();
});
$('input[name=workTypeSearch]').on('change',function() {
    checkWorkType();
});
$('input[name=statusSearch]').on('change',function() {
    checkStatus();
});
$('input[name=departmentSearch]').on('change',function() {
    checkDepartment();
});

//Change Pill button status based on Radio Button selected
function checkWorkType() {
    $("#workTypeButtonFullTime").removeClass('active');
    $("#workTypeButtonPartTime").removeClass('active');
    $("#workTypeButtonCasual").removeClass('active');
    $("#workTypeButtonContract").removeClass('active');
    if ($('input[id=workTypeSearchFullTime]').prop('checked')) {
        $("#workTypeButtonFullTime").addClass('active');
    }
    else if ($('input[id=workTypeSearchPartTime]').prop('checked')) {
        $("#workTypeButtonPartTime").addClass('active');
    }
    else if ($('input[id=workTypeSearchCasual]').prop('checked')) {
        $("#workTypeButtonCasual").addClass('active');
    }
    else if ($('input[id=workTypeSearchContract]').prop('checked')) {
        $("#workTypeButtonContract").addClass('active');
    }
}
function checkStatus() {
    $("#statusButtonDraft").removeClass('active');
    $("#statusButtonOpen").removeClass('active');
    $("#statusButtonClosed").removeClass('active');
    if ($('input[id=statusSearchDraft]').prop('checked')) {
        $("#statusButtonDraft").addClass('active');
    }
    else if ($('input[id=statusSearchOpen]').prop('checked')) {
        $("#statusButtonOpen").addClass('active');
    }
    else if ($('input[id=statusSearchClosed]').prop('checked')) {
        $("#statusButtonClosed").addClass('active');
    }
}
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
//Work Type Button Actions
$("#workTypeButtonFullTime").on('click',function() {
    document.getElementById('workTypeSearchFullTime').checked = true;
    document.getElementById('searchButton').click();
});
$("#workTypeButtonPartTime").on('click',function() {
    document.getElementById('workTypeSearchPartTime').checked = true;
    document.getElementById('searchButton').click();
});
$("#workTypeButtonCasual").on('click',function() {
    document.getElementById('workTypeSearchCasual').checked = true;
    document.getElementById('searchButton').click();
});
$("#workTypeButtonContract").on('click',function() {
    document.getElementById('workTypeSearchContract').checked = true;
    document.getElementById('searchButton').click();
});

//Status Button Actions
$("#statusButtonDraft").on('click',function() {
    document.getElementById('statusSearchDraft').checked = true;
    document.getElementById('searchButton').click();
});
$("#statusButtonOpen").on('click',function() {
    document.getElementById('statusSearchOpen').checked = true;
    document.getElementById('searchButton').click();
});
$("#statusButtonClosed").on('click',function() {
    document.getElementById('statusSearchClosed').checked = true;
    document.getElementById('searchButton').click();
});

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