//Upon page loading
$(window).on('load', function () {
    var modalTrigger = document.getElementById('modalTrigger').value;
    if (modalTrigger != '') {
        $('#messageModal').modal('show');
    }
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