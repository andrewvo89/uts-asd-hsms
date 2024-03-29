//Upon page loading
$(window).on('load', function () {
    var modalTrigger = document.getElementById('modalTrigger').value;
    if (modalTrigger != '') {
        $('#messageModal').modal('show');
    }
    checkWorkType();
    checkDepartment();
});

$('input[name=workTypeSearch]').on('change', function () {
    checkWorkType();
});
$('input[name=departmentSearch]').on('change', function () {
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
    } else if ($('input[id=workTypeSearchPartTime]').prop('checked')) {
        $("#workTypeButtonPartTime").addClass('active');
    } else if ($('input[id=workTypeSearchCasual]').prop('checked')) {
        $("#workTypeButtonCasual").addClass('active');
    } else if ($('input[id=workTypeSearchContract]').prop('checked')) {
        $("#workTypeButtonContract").addClass('active');
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
    } else if ($('input[id=departmentSearchEnglish]').prop('checked')) {
        $("#departmentButtonEnglish").addClass('active');
    } else if ($('input[id=departmentSearchMath]').prop('checked')) {
        $("#departmentButtonMath").addClass('active');
    } else if ($('input[id=departmentSearchScience]').prop('checked')) {
        $("#departmentButtonScience").addClass('active');
    } else if ($('input[id=departmentSearchArt]').prop('checked')) {
        $("#departmentButtonArt").addClass('active');
    }
}
//Work Type Button Actions
$("#workTypeButtonFullTime").on('click', function () {
    document.getElementById('workTypeSearchFullTime').checked = true;
    document.getElementById('searchButton').click();
});
$("#workTypeButtonPartTime").on('click', function () {
    document.getElementById('workTypeSearchPartTime').checked = true;
    document.getElementById('searchButton').click();
});
$("#workTypeButtonCasual").on('click', function () {
    document.getElementById('workTypeSearchCasual').checked = true;
    document.getElementById('searchButton').click();
});
$("#workTypeButtonContract").on('click', function () {
    document.getElementById('workTypeSearchContract').checked = true;
    document.getElementById('searchButton').click();
});

//Department Button Actions
$("#departmentButtonAdministration").on('click', function () {
    document.getElementById('departmentSearchAdministration').checked = true;
    document.getElementById('searchButton').click();
});
$("#departmentButtonEnglish").on('click', function () {
    document.getElementById('departmentSearchEnglish').checked = true;
    document.getElementById('searchButton').click();
});
$("#departmentButtonMath").on('click', function () {
    document.getElementById('departmentSearchMath').checked = true;
    document.getElementById('searchButton').click();
});
$("#departmentButtonScience").on('click', function () {
    document.getElementById('departmentSearchScience').checked = true;
    document.getElementById('searchButton').click();
});
$("#departmentButtonArt").on('click', function () {
    document.getElementById('departmentSearchArt').checked = true;
    document.getElementById('searchButton').click();
});
//JQuery functions to refresh page if idle for more than 10 seconds
var time = new Date().getTime();
$(document.body).bind("mousemove keypress", function (e) {
    time = new Date().getTime();
});
function refresh() {
    if (new Date().getTime() - time >= 10000)
        window.location.reload(true);
    else
        setTimeout(refresh, 10000);
}
setTimeout(refresh, 10000);