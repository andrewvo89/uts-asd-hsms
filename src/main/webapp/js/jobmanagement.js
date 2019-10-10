//Upon page loading
$(window).on('load', function() {   
    var modalTrigger = document.getElementById('modalTrigger').value;        
    if (modalTrigger != '') {
        $('#messageModal').modal('show');
    }
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
//Sort tables
//https://www.w3schools.com/howto/howto_js_sort_table.asp
function sortTableString(n) {
    var table, rows, switching, i, x, y, shouldSwitch, dir, switchcount = 0;
    table = document.getElementById("jobTable");
    switching = true;
    // Set the sorting direction to ascending:
    dir = "asc";
    /* Make a loop that will continue until
     no switching has been done: */
    while (switching) {
        // Start by saying: no switching is done:
        switching = false;
        rows = table.rows;
        /* Loop through all table rows (except the
         first, which contains table headers): */
        for (i = 1; i < (rows.length - 1); i++) {
            // Start by saying there should be no switching:
            shouldSwitch = false;
            /* Get the two elements you want to compare,
             one from current row and one from the next: */
            x = rows[i].getElementsByTagName("TD")[n];
            y = rows[i + 1].getElementsByTagName("TD")[n];
            /* Check if the two rows should switch place,
             based on the direction, asc or desc: */
            if (dir == "asc") {
                if (x.innerHTML.toLowerCase() > y.innerHTML.toLowerCase()) {
                    // If so, mark as a switch and break the loop:
                    shouldSwitch = true;
                    break;
                }
            } else if (dir == "desc") {
                if (x.innerHTML.toLowerCase() < y.innerHTML.toLowerCase()) {
                    // If so, mark as a switch and break the loop:
                    shouldSwitch = true;
                    break;
                }
            }
        }
        if (shouldSwitch) {
            /* If a switch has been marked, make the switch
             and mark that a switch has been done: */
            rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
            switching = true;
            // Each time a switch is done, increase this count by 1:
            switchcount++;
        } else {
            /* If no switching has been done AND the direction is "asc",
             set the direction to "desc" and run the while loop again. */
            if (switchcount == 0 && dir == "asc") {
                dir = "desc";
                switching = true;
            }
        }
    }
}
function sortTableDate(n) {
    var table, rows, switching, i, x, y, shouldSwitch, dir, switchcount = 0;
    table = document.getElementById("jobTable");
    switching = true;
    // Set the sorting direction to ascending:
    dir = "asc";
    /* Make a loop that will continue until
     no switching has been done: */
    while (switching) {
        // Start by saying: no switching is done:
        switching = false;
        rows = table.rows;
        /* Loop through all table rows (except the
         first, which contains table headers): */
        for (i = 1; i < (rows.length - 1); i++) {
            // Start by saying there should be no switching:
            shouldSwitch = false;
            /* Get the two elements you want to compare,
             one from current row and one from the next: */
            x = rows[i].getElementsByTagName("TD")[n];
            y = rows[i + 1].getElementsByTagName("TD")[n];
            /* Check if the two rows should switch place,
             based on the direction, asc or desc: */
            if (dir == "asc") {
                if (convertDate(x.innerHTML) > convertDate(y.innerHTML)) {
                    // If so, mark as a switch and break the loop:
                    shouldSwitch = true;
                    break;
                }
            } else if (dir == "desc") {
                if (convertDate(x.innerHTML) < convertDate(y.innerHTML)) {
                    // If so, mark as a switch and break the loop:
                    shouldSwitch = true;
                    break;
                }
            }
        }
        if (shouldSwitch) {
            /* If a switch has been marked, make the switch
             and mark that a switch has been done: */
            rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
            switching = true;
            // Each time a switch is done, increase this count by 1:
            switchcount++;
        } else {
            /* If no switching has been done AND the direction is "asc",
             set the direction to "desc" and run the while loop again. */
            if (switchcount == 0 && dir == "asc") {
                dir = "desc";
                switching = true;
            }
        }
    }
}
//Convert date to a sortable format 05-12-2019 convert to 20191205
function convertDate(date) {
    var dateString = date.split("-");
    return (dateString[2] + dateString[1] + dateString[0]);
}
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