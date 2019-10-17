/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
//Upon page loading
$(window).on("load", function () {
    
    $('input[type="submit"], input[type="button"], button').disable(true);
    
    //$('#feedbackSuccess').modal({ show: false});
});

//Character count for textarea
    var text_max = 500;
    $('#count_message').html(text_max + '/500 remaining');

    $('#commentAdd').keyup(function() {
      var text_length = $('#commentAdd').val().length;
      var text_remaining = text_max - text_length;

    $('#count_message').html(text_remaining + '/500 remaining');
});

//Checks if comment area is empty or not
$(function() {
    jQuery.fn.extend({
        disable: function(state) {
            return this.each(function() {
                this.disabled = state;
            });
        }
    });
    var comment = document.getElementById("commentAdd").value.trim(); 
    
    $('#commentAdd').keyup(function() {
       if (comment != "") {
         $('input[type="submit"], input[type="button"], button').disable(true);  
       } else {
         $('input[type="submit"], input[type="button"], button').disable(false);  
       }
    });
}); 

//Checks if word count is over 500


$("#checkCount").on("click", function() {
    var comment = document.getElementById("commentAdd").value; 
    submitOk = "false";
    if (comment.length > 500){
        alert("Please keep your response to under 500 characters");
        submitOk = "false";
    } else { 
    //    submitOk == "true";
        document.complaintForm.submit();
    }
    if (submitOk == "false") {
        return false;
    }
    //if (submitOk == "true") {
    //    $('#feedbackSuccess').modal('show');
    //    return true;
    //}
});
