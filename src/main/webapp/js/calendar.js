/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$(window).on("load", function () {
    var modalTrigger = document.getElementById("modalTrigger").value;
    if (modalTrigger != "") {
        $("#messageModal").modal("show");
    }
    checkEventTag();
});

//Change Pill button status based on Radio Button selected
function checkeventTag() {
    $("#eventTagButtonPersonal").removeClass("active");
    $("#eventTagButtonWork").removeClass("active");
    $("#eventTagButtonSchool").removeClass("active");
   
    if ($("input[id=eventTagSearchPersonal]").prop("checked")) {
        $("#eventTagButtonPersonal").addClass("active");
    }
    else if ($("input[id=eventTagSearchWork]").prop("checked")) {
        $("#eventTagButtonWork").addClass("active");
    }
    else if ($("input[id=eventTagSearchSchool]").prop("checked")) {
        $("#eventTagButtonSchool").addClass("active");
    }
}

//Event Tag Button Actions
$("#eventTagButtonPersonal").on("click",function() {
    document.getElementById("eventTagSearchPersonal").checked = true;
    document.getElementById("searchButton").click();
});
$("#eventTagButtonWork").on("click",function() {
    document.getElementById("eventTagSearchWork").checked = true;
    document.getElementById("searchButton").click();
});
$("#eventTagButtonSchool").on("click",function() {
    document.getElementById("eventTagSearchSchool").checked = true;
    document.getElementById("searchButton").click();
});

