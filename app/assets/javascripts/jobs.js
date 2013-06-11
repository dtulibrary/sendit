$(function() {
    $("#delayed-job").load(function() {
        $(this).height( $(this).contents().find("body").height() + 100);
    });
});
