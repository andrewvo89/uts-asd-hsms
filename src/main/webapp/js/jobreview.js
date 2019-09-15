//Upon page loading
$(window).on('load', function () {
    var modalTrigger = document.getElementById('modalTrigger').value;
    if (modalTrigger != '') {
        $('#messageModal').modal('show');
    }
});